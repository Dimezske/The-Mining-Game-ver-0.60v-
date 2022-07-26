extends Area2D

var player_in_range : bool
func _on_OutsideWorldtoStartmine_entrance1_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		get_tree().change_scene(("res://Scenes/Startmine.tscn"))
		Global.player_initial_map_position = Vector2(370,-370)
		if get_tree().current_scene.filename == "res://Scenes/Startmine.tscn":
			print(get_tree().current_scene.filename + "At Position: " + Global.player_initial_map_position)
