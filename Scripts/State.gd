#extends KinematicBody2D
#class_name playerState
#
#var state_machine = null
#
#var player_velocity = Vector2()
#var player_speed = 200
#var player_energy = 50
#
#enum playerStates{IDLE, WALK, RUN, USE, SHOOT}
#var state: playerStates
#var parent = get_parent()
#
#func _physics_process(_delta):
#	match state:
#	   playerStates.IDLE:
#		   state = playerStates.IDLE
#	   playerStates.WALK:
#		   state = playerStates.WALK
#	   playerStates.RUN:
#		   state = playerStates.RUN
#	   playerStates.USE:
#		   state = playerStates.USE
#	   playerStates.SHOOT:
#		   state = playerStates.SHOOT
#
#func set_state(new_value:playerStates) -> void:
#	if state == new_value:
#		return
#
#	match new_value:
#		playerStates.IDLE:
#			pass # code here
#		playerStates.WALK:
#			pass # code here
#		playerStates.RUN:
#			pass # code here
#		playerStates.USE:
#			pass # code here
#		playerStates.SHOOT:
#			pass # code here
#
#	state = new_value
#
##
##func _ready():
##	call_deferred(playerStates == State.state_machine == playerStates.IDLE)
##	print("IDLE STATE")
##	if Global.player_isIdle == State.state_machine == playerStates.IDLE:
##		pass
##	if Global.player_isWalking == State.state_machine == playerStates.WALK:
##		Global.player_isWalking = true
##		State.player_speed = Global.player_speed
##		State.player_speed = 200
##
##	if Global.player_isRunning == State.state_machine == playerStates.RUN:
##		Global.player_isRunning = true
##		State.player_speed = Global.player_speed
##		State.player_speed = 300
##
##func handle_input(_event: InputEvent):
##	if Global.player_velocity != Global.player_velocity.ZERO:
##		if Global.player_isWalking == State.state_machine == playerStates.WALK:
##			pass
##		if Global.player_isRunning == State.state_machine == playerStates.RUN:
##			if Input.is_action_pressed("sprint"):
##				print("RUN")
##		Global.player_velocity = Global.player_velocity.normalized() * player_speed
##		Global.player_velocity = move_and_slide(Global.player_velocity)
##
##func _physics_process(_delta):
##	Global.player_velocity = parent.move_and_slide(Global.player_velocity)
