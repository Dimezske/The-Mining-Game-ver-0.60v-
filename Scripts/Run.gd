extends StateMachine



func input():
	player.velocity = Vector2()
	player.speed = Global.player_speed
	
	if Input.is_action_pressed("sprint"):
		return player.STATES.RUN
		#Global.player_isRunning = true 
		player.speed = 300
		if Input.is_action_pressed("move-right"):
			Global.player_direction = "0"
			player.velocity.x += 1
			if self.getPlayer.get_node("Footsteps").playing == false:
				self.getPlayer.get_node("Footsteps").play()
		if Input.is_action_pressed("move-left"):
			Global.player_direction = "1"
			player.velocity.x -= 1
			if self.getPlayer.get_node("Footsteps").playing == false:
				self.getPlayer.get_node("Footsteps").play()
		if Input.is_action_pressed("move-down"):
			Global.player_direction = "2"
			player.velocity.y += 1
			if self.getPlayer.get_node("Footsteps").playing == false:
				self.getPlayer.get_node("Footsteps").play()
		if Input.is_action_pressed("move-up"):
			Global.player_direction = "3"
			player.velocity.y -= 1
			if self.getPlayer.get_node("Footsteps").playing == false:
				self.getPlayer.get_node("Footsteps").play()
			#if $Footsteps.playing == false:
				#$Footsteps.play()
	
			player.velocity = player.velocity.normalized() * player.speed
			player.velocity = player.move_and_slide(player.velocity)
	else:
		player.speed = 200

	
