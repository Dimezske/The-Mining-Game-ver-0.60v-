extends KinematicBody2D


var item_name

var player = null
var being_picked_up = false

func _ready():
	item_name = "C4 Small"
	
func _physics_process(_delta):
	if being_picked_up == false:
		pass
	else:
		PlayerInventory.add_item(item_name, 1)
		queue_free()
	#velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
