extends Node2D

onready var animatedSprite = $AnimatedSprite

func _process(delta):
	if Input.is_action_just_pressed("use"):
		animatedSprite.play("Animate")
	
func _on_AnimatedSprite_animation_finished():
	print("blood")
	queue_free()
