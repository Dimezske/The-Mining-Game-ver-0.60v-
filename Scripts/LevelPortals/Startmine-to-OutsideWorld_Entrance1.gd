extends Area2D

var player_in_range : bool

func _on_StartminetoOutsideWorld_Entrance1_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		get_tree().change_scene(("res://Scenes/OutsideWorld.tscn"))
		Global.player_initial_map_position = Vector2(4920,400)
		if get_tree().current_scene.filename == "res://Scenes/OutsideWorld.tscn":
			print(get_tree().current_scene.filename + "At Position: " + Global.player_initial_map_position)
