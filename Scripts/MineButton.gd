extends Area2D

var player_in_range : bool
var pressed_button : bool = false
var Character = null
onready var button = $CollisionShape2D

func _on_MineButton_body_entered(body):
	pressed_button = false
	if body.name == "Player":
		player_in_range = true
		if Input.is_action_just_pressed("interact") and button == body.name == "Player":
			pressed_button = false
			print("pressed_button false")
	

func _on_MineButton_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		pressed_button = false
		print("pressed_button false")
