extends Node2D


func _ready():
	pass # Replace with function body.

#func _unhandled_input(event):
#	if event is InputEventAction and Input.is_action_just_pressed("use"):
#		EventBus.emit_signal("hide_ui_for_enemy", self)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		print("TileMap> use pressed: ", Input.is_action_just_pressed("use"))
		if Input.is_action_just_pressed("use"):
			EventBus.emit_signal("hide_ui_for_enemy", self)
