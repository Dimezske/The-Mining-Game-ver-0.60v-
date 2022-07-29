extends KinematicBody2D

var speed = 200
var motion = Vector2.ZERO
var player = null

func _physics_process(_delta):
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
	motion = move_and_slide(motion)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		 player = null
