extends MarginContainer
func _input(event):
	if OS.is_window_maximized() == true:
		$HBoxContainer.set_position(Vector2(0,390))
	else:
		$HBoxContainer.set_position(Vector2(0,0))
		
	if OS.window_fullscreen == true:
		$HBoxContainer.set_position(Vector2(0,440))
	else:
		$HBoxContainer.set_position(Vector2(0,0))
func _physics_process(_delta):
	$HBoxContainer/VBoxContainer/Stat1.text = "FPS: " + str(Performance.get_monitor(Performance.TIME_FPS))
	$HBoxContainer/VBoxContainer/Stat2.text = "Memory Static: " + str(round(Performance.get_monitor(Performance.MEMORY_STATIC)/1024/1024)) + " MB"
	
