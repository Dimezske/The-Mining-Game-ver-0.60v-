extends StateMachine



func input():
	player.velocity = Vector2()
	player.speed = Global.player_speed
	if player.velocity == 0:
		return player.STATES.IDLE
	player.velocity = player.velocity.normalized() * player.speed
	player.velocity = player.move_and_slide(player.velocity)

func _ready():
	pass # Replace with function body.
