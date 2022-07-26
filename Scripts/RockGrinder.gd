extends StaticBody2D
var player_in_range : bool
export var item_name = "MineRocks"
var quantity = 1
var player = null

enum{
	MOVE,
	GRINDING
}
export var SPEED = 100
var state = MOVE
var item_drop = load("res://Scenes/RocksPath.tscn")

onready var inventory = get_tree().get_root().get_node("Game/World/YSort/Character/UserInterface/Inventory")
#onready var inventory = get_parent().get_parent().get_node("UserInterface/Inventory")
onready var grid = inventory.get_child(2)


func choose(array):
	array.shuffle()
	return array.front()

func _on_Timer_timeout():
	$Timer.wait_time = choose([3.5, 6])
	state = choose([MOVE,GRINDING])
func _input(event):
	if player_in_range and event.is_action_pressed("interact"):
		for i in grid.get_child_count():
			if(grid.get_child(i).item and grid.get_child(i).item.item_name == "MineRocks"):
				grind_item(grid.get_child(i).item, i)
				
func init(item):
	var new_item
	item_name = item.item_name
	quantity = item.item_quantity
	if item_name == "MineRocks" and player_in_range:
		item = new_item
		item.position = Vector2(0, 0)
		var placementNode = find_parent("PlaceCollison")    
		placementNode.remove_child(item)
		add_child(item)
		$Sprite.texture = item.get_node("TextureRect").texture
		
func grind_item(item, i):
	var new_drop = item_drop.instance()
	$PlaceRocks.add_child(new_drop)
	
	item.item_quantity -= 1
	if item.item_quantity <= 0:
		PlayerInventory.remove_item(grid.get_child(i))
		grid.get_child(i).pickFromSlot()
		var x = inventory.find_parent("UserInterface").get_child(inventory.find_parent("UserInterface").get_child_count() - 1)
		inventory.find_parent("UserInterface").remove_child(x)


func _on_PlaceRocks_body_entered(body):
	if body.name == "Player":
		print("player detected")
		player_in_range = true
		
func _on_PlaceRocks_body_exited(body):
	if body.name == "Player":
		player_in_range = false
