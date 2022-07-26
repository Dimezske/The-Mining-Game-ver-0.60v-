extends Position2D

signal spawned(spawn)

export(PackedScene) var spawnling_scene

func spawn():
	var spawnling = spawnling_scene.instance()
	add_child(spawnling)
	spawnling.global_position = global_position
	return spawnling


func _on_Timer_timeout():
	spawn()
