extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func animate(velocity):
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("IdleHold")
	else:
		$AnimationTree.get("parameters/playback").travel("WalkHold")
		$AnimationTree.set("parameters/IdleHold/blend_position", velocity)
		$AnimationTree.set("parameters/WalkHold/blend_position", velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
