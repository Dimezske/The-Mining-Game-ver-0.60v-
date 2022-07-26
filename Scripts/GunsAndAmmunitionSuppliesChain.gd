extends StaticBody2D
var player_in_range : bool



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("player detected")
		player_in_range = true
		$Building/Front.visible = false
		$Building/Roof.visible = false
		get_node("Building/FrontCollision").disabled = true 


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		$Building/Front.visible = true
		$Building/Roof.visible = true
		get_node("Building/FrontCollision").disabled = false
