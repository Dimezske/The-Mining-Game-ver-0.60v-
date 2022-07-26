extends StateMachine


func input():
	if Input.is_action_just_pressed("interact"):
		return player.STATES.USE
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
