#Hotbar.gd
extends Node2D
signal hotbar_slot_change(slotNumber, ItemAdded)
const SlotClass = preload("res://Scripts/Slot.gd")
onready var hotbar_slots = $HotbarSlots
onready var active_item_label = $ActiveItemLabel
onready var slots = hotbar_slots.get_children()
onready var usable_tools = Global.player_node.tools
onready var usable_weapons = Global.player_node.weapons


var mining_drills = {
	"MiningDrill Starter": load("res://Assets/Tools/Starter_drill1.png")
}
var assault_rifles = {
	"M4": load("res://Assets/Weapons/Guns/M4A1_new.png")
}
func _ready():
	PlayerInventory.connect("active_item_updated", self, "update_active_item_label")
	for i in range(slots.size()):
		PlayerInventory.connect("active_item_updated", slots[i], "refresh_style")
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].connect("mouse_entered", self, "slot_mouse_entered")
		slots[i].connect("mouse_exited", self, "slot_mouse_exited")
		slots[i].slot_type = SlotClass.SlotType.HOTBAR
		slots[i].slot_index = i
	slots[0].slot_type = SlotClass.SlotType.HOTBAR
	slots[1].slot_type = SlotClass.SlotType.HOTBAR
	slots[2].slot_type = SlotClass.SlotType.HOTBAR
	slots[3].slot_type = SlotClass.SlotType.HOTBAR
	slots[4].slot_type = SlotClass.SlotType.HOTBAR
	initialize_hotbar()
	update_active_item_label()
	self.connect("hotbar_slot_change",self, "_on_set_mining_drill") 
	
func update_active_item_label():
	if slots[PlayerInventory.active_item_slot].item != null:
		active_item_label.text = slots[PlayerInventory.active_item_slot].item.item_name
		print("checking hotbar slot: " + slots[PlayerInventory.active_item_slot].item.item_name)
#		playerNode.equip(weapon_name)
		Global.playerNode.equip(slots[PlayerInventory.active_item_slot].item.item_name, self)
	else:
		active_item_label.text = ""
		
func initialize_hotbar():
	for i in range(slots.size()):
		if PlayerInventory.hotbar.has(i):
			slots[i].initialize_item(PlayerInventory.hotbar[i][0], PlayerInventory.hotbar[i][1])

func _input(event):
	if find_parent("UserInterface").holding_item:
		find_parent("UserInterface").holding_item.global_position = get_global_mouse_position()
		if event is InputEventMouseButton:
				if event.button_index == BUTTON_LEFT && event.pressed:
					if !find_parent("UserInterface").mouse_over_slot:
						drop_item()

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
			update_active_item_label()
func drop_item():
	var item = find_parent("UserInterface").holding_item
	if item == null:
		return
	var item_drop = preload("res://Scenes/ItemDrop.tscn").instance()
	item_drop.init(item)
	var player = get_tree().current_scene.find_node("Player", true)
	item_drop.global_position = player.global_position
	get_tree().current_scene.find_node("YSort", true).add_child(item_drop)
	
	find_parent("UserInterface").holding_item.queue_free()
	find_parent("UserInterface").holding_item = null
func left_click_empty_slot(slot: SlotClass):
	PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
	slot.putIntoSlot(find_parent("UserInterface").holding_item)
	find_parent("UserInterface").holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(find_parent("UserInterface").holding_item)
	find_parent("UserInterface").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
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

func _on_set_mining_drill(slotNumber, ItemAdded):
	pass
	if !ItemAdded:
		usable_tools.visible = false
	if mining_drills.has("MiningDrill Starter") == ItemAdded:
		usable_tools.visible = true
		slotNumber = slots[0].slot_type
		Global.isHoldingTool = true
		Global.hasMiningDrill = true
		slotNumber = slots[0].slot_type
	Global.player_node.tools = mining_drills["MiningDrill Starter"]

func _on_change_mining_drill():
	emit_signal("hotbar_slot_change", $HotbarSlots/HotbarSlot1,true)
	pass
func _on_set_assault_rifle(slotNumber, ItemAdded):
	if !ItemAdded:
		usable_weapons.visible = false
	if assault_rifles.has("M4") == ItemAdded:
		usable_weapons.visible = true
		slotNumber = slots[0].slot_type
		Global.isHoldingTool = true
		Global.hasMiningDrill = true
		slotNumber = slots[0].slot_type
	Global.player_node.weapons = assault_rifles["M4"]
	pass
func _on_change_assault_rifle():
	emit_signal("hotbar_slot_change", $HotbarSlots/HotbarSlot1,true)
	pass
func _on_equip_weapon(slotNumber, weapons):
	if weapons == null:
		usable_weapons.visible = false
		Global.isHoldingWeapon = false
	else:
		usable_weapons.visible = true
		slotNumber = slots[0].slot_type
		Global.isHoldingWeapon = true

func _on_equip_tool(slotNumber, tools):
	if tools == null:
		usable_tools.visible = false
		Global.isHoldingTool = false
	else:
		usable_tools.visible = true
		slotNumber = slots[0].slot_type
		Global.isHoldingTool = true
