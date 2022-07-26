extends PanelContainer
const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $Inventory
var holding_item = null
var isInventory : bool

func _ready():
	var slots = inventory_slots.get_children()
	
func _input(_event):
	open_inventory()
	
func open_inventory():
	if Input.is_action_just_pressed("new_inventory"):
		isInventory = !isInventory
		if isInventory:
			$".".visible = true
			#$"GridContainer".visible = true
			print('true')
		else:
			$".".visible = false
			#$"GridContainer".visible = false
			print('false')
