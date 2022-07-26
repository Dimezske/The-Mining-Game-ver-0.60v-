extends Node

signal level_changed(level_name)

export (String) var level_name = "level"

func _on_ChangeSceneButton_pressed() -> void:
	emit_signal("level_changed", level_name)
