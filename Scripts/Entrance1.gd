extends Area2D
var loadOutsideLevel : bool
var loadStartmineLevel : bool
func _on_Entrance_body_entered(_body):
# warning-ignore:return_value_discarded
	
	if loadStartmineLevel == true:
		get_tree().change_scene(("res://Scenes/Startmine.tscn"))
		Global.player_initial_map_position = Vector2(0,200)
		if get_tree().current_scene.name == "res://Scenes/Startmine.tscn":
			print(get_tree().current_scene.name)
	
