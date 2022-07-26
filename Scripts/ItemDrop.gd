#ItemDrop.gd
extends KinematicBody2D
const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
export var item_name = "Slime Potion"
var quantity = 1

var player = null
var being_picked_up = false

func _ready():
#	item_name = "Slime Potion"
	if quantity <= 1:
		$quantityLbl.hide()
	pass
func _physics_process(delta):
	if being_picked_up == false:
		velocity = velocity.move_toward(Vector2(0, 0), ACCELERATION * delta)
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, quantity)
			queue_free()
	velocity = move_and_slide(velocity, Vector2.UP)
	#velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
	
func init(item):
	item_name = item.item_name
	quantity = item.item_quantity
	$quantityLbl.text = str(quantity)
	if quantity > 1:
		$quantityLbl.show()
	else:
		$quantityLbl.hide()
	if item_name == "Slime Potion":
		$Sprite.scale = Vector2(1,1)
	elif item_name == "M4":
		$Sprite.scale = Vector2(0.75,1)
	elif item_name == "Trm17":
		$Sprite.scale = Vector2(1.3,1.5)
	elif item_name == "9mm Ammunition":
		$Sprite.scale = Vector2(0.65,0.7)
	else:
		$Sprite.scale = Vector2(1,1)
	
	$Sprite.texture = item.get_node("TextureRect").texture
#func init(item):
#	item_name = item.item_name
#	quantity = item.item_quantity
#	$quantityLbl.text = str(quantity)
#	if quantity > 1:
#		$quantityLbl.show()
#	else:
#		$quantityLbl.hide()
#	$Sprite.texture = item.get_node("TextureRect").texture
