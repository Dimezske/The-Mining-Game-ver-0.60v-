
extends Node2D

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 3
	if rand_val == 0:
		item_name = "M4"
	elif rand_val == 1:
		item_name = "M4"
	else:
		item_name = "M4"
	
	$TextureRect.texture = load("res://Assets/Items/Icons/" + item_name + ".png")
	$TextureRect.texture = load("res://Assets/Items/Icons/Clothing-Icons/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.text = String(item_quantity)

func set_item(nm, qt):
	item_name = nm
	item_quantity = qt
	$TextureRect.texture = load("res://Assets/Items/Icons/" + item_name + ".png")
	$TextureRect.texture = load("res://Assets/Items/Icons/Clothing-Icons/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quantity)
		
func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)
	
func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)
	


## Called when the node enters the scene tree for the first time.
#func _ready():
#	if randi() % 3 == 0:
#		pass
#		$TextureRect.texture = load("res://Assets/Items/Icons/M4.png")
#
#	else:
#		pass
#		$TextureRect.texture = load("res://Assets/Items/rocks1.png")
#
