extends CanvasLayer

var box
func _on_ItemPickupCollision_body_entered(_body):
	if _body.is_in_group("Box"):
		box = _body
		get_node("HUD/pickup_button").modulate = Color(0.670588, 1, 0.839216)

func _on_ItemPickupCollision_body_exited(_body):
	get_node("HUD/pickup_button").modulate = Color(0, 1, 0.501961)
	

	
