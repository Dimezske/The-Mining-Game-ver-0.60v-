extends StateMachine


onready var playerPath = load("res://Scenes/Player.tscn")
onready var bulletPath = load("res://Scenes/Bullet.tscn")

export var bullet_speed: int
export var isShooting: bool


func fire():
	var player = playerPath.instance()
	var bullet_instance = bulletPath.instance()
	if Global.player_direction == "0":
		bullet_speed = 500
		print('FIRE!')
		print(Global.player_direction)
		isShooting = true 
		
		#bullet_instance.position = $Muzzle.get_global_position()
		#bullet_instance.rotation_degrees = rotation_degrees
		#look_at(get_global_mouse_position())
		#$M4A1Sprite.flip_h = false
		#$M4A1Sprite.flip_v = false
		#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		#get_tree().get_root().add_child(bullet_instance)
		
	if Global.player_direction == "1":
		bullet_speed = 500
		print('FIRE!')
		print(Global.player_direction)
		isShooting = true 
#		bullet_instance.position = $Muzzle.get_global_position()
#		bullet_instance.rotation_degrees = rotation_degrees
#		look_at(get_global_mouse_position())
#		$M4A1Sprite.flip_h = true
#		$M4A1Sprite.flip_v = true
#		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
		
	if Global.player_direction == "2":
		bullet_speed = 500
		print('FIRE!')
		print(Global.player_direction)
		isShooting = true 
#		bullet_instance.position = $Muzzle.get_global_position()
#		bullet_instance.rotation_degrees = rotation_degrees + (270 / PI)
#		look_at(get_global_mouse_position())
#		bullet_instance.apply_impulse(Vector2(), Vector2(0, bullet_speed).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
		
	if Global.player_direction == "3":
		bullet_speed = -500
		print('FIRE!')
		print(Global.player_direction)
		isShooting = true 
#		bullet_instance.position = $Muzzle.get_global_position() + Vector2(0,0)
#		bullet_instance.rotation_degrees = rotation_degrees + (-270 / PI)
#		look_at(get_global_mouse_position())
#		bullet_instance.apply_impulse(Vector2(), Vector2(0, bullet_speed).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
func _ready():
	pass # Replace with function body.
