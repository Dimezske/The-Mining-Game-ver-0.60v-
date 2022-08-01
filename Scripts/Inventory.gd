#Inventory.gd
extends Node2D

#const SlotClass = preload("res://Slot.gd")
const SlotClass = preload("res://Scripts/Slot.gd")
onready var inventory_slots = $GridContainer
onready var equip_slots = $EquipSlots
var mouse_over_slot = false
func _ready():
#	var slots = inventory_slots.get_children()
#	for i in range(slots.size()):
#		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
#		slots[i].slot_index = i
#		slots[i].slot_type = SlotClass.SlotType.INVENTORY
#	initialize_inventory()
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].connect("mouse_entered", self, "slot_mouse_entered")
		slots[i].connect("mouse_exited", self, "slot_mouse_exited")
		slots[i].slot_index = i
		slots[i].slot_type = SlotClass.SlotType.INVENTORY
			

#	SHIRTS,
#	SHORTS,
#	PANTS,
#	SHOES,
#	NECKLACES,
#	BACKPACKS,
#	LEFTRINGS,
#	RIGHTRINGS,
#	VESTS,
#	GRENADES,
#	LEFTUTILITIES,
#	RIGHTUTILITIES,
	for i in range(equip_slots.size()):
		equip_slots[i].connect("gui_input", self, "slot_gui_input", [equip_slots[i]])
#		equip_slots[i].connect("mouse_entered", self, "slot_mouse_entered")
#		equip_slots[i].connect("mouse_exited", self, "slot_mouse_exited")
		equip_slots[i].slot_index = i
	equip_slots[0].slotType = SlotClass.SlotType.SHIRTS
	equip_slots[1].slotType = SlotClass.SlotType.NECKLACES
	equip_slots[2].slotType = SlotClass.SlotType.VESTS
	equip_slots[3].slotType = SlotClass.SlotType.SHORTS
	equip_slots[4].slotType = SlotClass.SlotType.BACKPACKS
	equip_slots[5].slotType = SlotClass.SlotType.GRENADES
	equip_slots[6].slotType = SlotClass.SlotType.PANTS
	equip_slots[7].slotType = SlotClass.SlotType.LEFTRINGS
	equip_slots[8].slotType = SlotClass.SlotType.LEFTUTILITIES
	equip_slots[9].slotType = SlotClass.SlotType.SHOES
	equip_slots[10].slotType = SlotClass.SlotType.RIGHTRINGS
	equip_slots[11].slotType = SlotClass.SlotType.RIGHTUTILITIES
	
		
	initialize_inventory()
	initialize_equips()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func initialize_equips():
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			equip_slots[i].initialize_item(PlayerInventory.equips[i][0], PlayerInventory.equips[i][1])

func slot_mouse_entered():
	find_parent("UserInterface").mouse_over_slot = true
	
func slot_mouse_exited():
	find_parent("UserInterface").mouse_over_slot = false

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if find_parent("UserInterface").holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					if find_parent("UserInterface").holding_item.item_name != slot.item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)

func _input(event):
	if find_parent("UserInterface").holding_item:
		find_parent("UserInterface").holding_item.global_position = get_global_mouse_position()
		
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				if !find_parent("UserInterface").mouse_over_slot:
					
					drop_item()

#func drop_item():
#	var item = find_parent("UserInterface").holding_item
#	if item == null:
#		return
#	var item_drop = preload("res://ItemDrop.tscn").instance()
#	item_drop.init(item)
#	item_drop.global_position = item.global_position
#	get_tree().current_scene.add_child(item_drop)
#
#	find_parent("UserInterface").holding_item.queue_free()
#	find_parent("UserInterface").holding_item = null
func drop_item():
	var item = find_parent("UserInterface").holding_item
	if item == null:
		return
	#var item_drop = preload("res://ItemDrop.tscn").instance()
	var item_drop = preload("res://Scenes/ItemDrop.tscn").instance()
	item_drop.init(item)
	var player = get_tree().current_scene.find_node("Player", true)
	item_drop.global_position = player.global_position
	get_tree().current_scene.find_node("YSort", true).add_child(item_drop)
	
	find_parent("UserInterface").holding_item.queue_free()
	find_parent("UserInterface").holding_item = null
	
func able_to_put_into_slot(slot: SlotClass):
	var holding_item = find_parent("UserInterface").holding_item
	if holding_item == null:
		return true
	var holding_item_category = JsonData.item_data[holding_item.item_name]["ItemCatagory"]
	
#	if slot.slotType == SlotClass.SlotType.SHIRT:
#		return holding_item_category == "Shirt"
#	elif slot.slotType == SlotClass.SlotType.PANTS:
#		return holding_item_category == "Pants"
#	elif slot.slotType == SlotClass.SlotType.SHOES:
#		return holding_item_category == "Shoes"
	return true

func left_click_empty_slot(slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
		slot.putIntoSlot(find_parent("UserInterface").holding_item)
		find_parent("UserInterface").holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
		var temp_item = slot.item
		slot.pickFromSlot()
		temp_item.global_position = event.global_position
		slot.putIntoSlot(find_parent("UserInterface").holding_item)
		find_parent("UserInterface").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
	if able_to_put_into_slot(slot):
		var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
		var able_to_add = stack_size - slot.item.item_quantity
		if able_to_add >= find_parent("UserInterface").holding_item.item_quantity:
			PlayerInventory.add_item_quantity(slot, find_parent("UserInterface").holding_item.item_quantity)
			slot.item.add_item_quantity(find_parent("UserInterface").holding_item.item_quantity)
			find_parent("UserInterface").holding_item.queue_free()
			find_parent("UserInterface").holding_item = null
		else:
			PlayerInventory.add_item_quantity(slot, able_to_add)
			slot.item.add_item_quantity(able_to_add)
			find_parent("UserInterface").holding_item.decrease_item_quantity(able_to_add)

func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	find_parent("UserInterface").holding_item = slot.item
	slot.pickFromSlot()
	find_parent("UserInterface").holding_item.global_position = get_global_mouse_position()


func _on_TextureButton_pressed():
	$EquipSlots.visible = !$EquipSlots.visible
	if !$EquipSlots.visible:
		mouse_over_slot = false
	$ClothingRect.visible = !$ClothingRect.visible
	if !$ClothingRect.visible:
		mouse_over_slot = false
	$ClothingText.visible = !$ClothingText.visible
	if !$ClothingText.visible:
		mouse_over_slot = false
	#$Inventory.initialize_inventory()
