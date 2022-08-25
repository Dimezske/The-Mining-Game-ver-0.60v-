extends Node2D

const MAX_LENGTH = 2000

onready var gun = get_parent().get_node("Node2D/Sprite")
onready var end = $EndOfSight
onready var rayCast2D = $RayCast2D


func _physics_process(_delta):
	var mouse_position = get_local_mouse_position()
	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
	rayCast2D.cast_to = max_cast_to
	if rayCast2D.is_colliding():
		end.global_position = rayCast2D.get_collision_point()
	else:
		end.global_position = rayCast2D.cast_to
	gun.rotation = rayCast2D.cast_to.angle()
	gun.region_rect.end.x = end.position.length()
	if Global.player_direction[0]:
		gun.flip_h = true
		
