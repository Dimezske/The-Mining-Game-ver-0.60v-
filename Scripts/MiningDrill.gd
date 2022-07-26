extends Area2D
class_name Tool
onready var playerPath = preload("res://Player.tscn")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox: Area2D = get_node("Node2D/Sprite/Hitbox")
export(bool) var on_floor: bool = true

var parent_velocity = Vector2()
var velocity = Vector2()

var player_in_range : bool
var player_picked_up : bool
var hasTool : bool = false

var BatteryAmount: int
var DestructionSpread: Array = [0,0]

var damage: float
var freeze: float
var hasEquiped: bool
var hasAttachedMod1: bool
var hasAttachedMod2: bool
var hasAttachedMod3: bool
var isUsing : bool
var isLazer : bool

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var MiningDrill: Array = ["Starter"]
var miningdrill_types = MiningDrills

onready var MiningDrills : Dictionary =  {
	 "Starter" : load("res://MiningDrill")

}
func _process(_delta):
	_miningdrills_input()
	#_guns_animation()
	_miningDrills_Animation()
	_pick_up_tool()
	toggle_lazer()
	hasAttachedMod1 = true
	hasAttachedMod2 = true
	if Input.is_action_just_pressed("interact"):
		if player_picked_up == true:
			player_picked_up = false
		else:
			if player_in_range == true:
				player_picked_up = true
				print(player_picked_up)
				Global.hasM4a1 = true
				hasTool = true


func _pick_up_tool():
	if Input.is_action_just_pressed("interact"):
		if player_picked_up == true:
			player_picked_up = false
		else:
			if player_in_range == true:
				player_picked_up = true
				print(player_picked_up)
				hasTool = true

func _miningdrills_input():
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire") and hasTool:
		if $M4A1_Shoot_Sound.playing == false:
			$M4A1_Shoot_Sound.play()
			isUsing = true
			use() # == null
	if Input.is_action_pressed("fire") and hasTool:
		if $M4A1_Shoot_Sound.playing == false:
			$M4A1_Shoot_Sound.play()
			isUsing = true
			use() # == null
	else:
		isUsing = false
func _on_MiningDrill_body_entered(body):
	pass # Replace with function body.


func _on_MiningDrill_body_exited(body):
	pass # Replace with function body.
func use():
	var player = playerPath.instance()
	#var bullet_instance = M4A1_bulletPath.instance()
	if Global.player_direction == "0":
		pass
		#bullet_speed = 500
		#print('FIRE!')
		#print(Global.player_direction)
		#isShooting = true 
		#bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position()
		#bullet_instance.rotation_degrees = rotation_degrees
		#look_at(get_global_mouse_position())
		#$Node2D/Sprite.flip_h = false
		#$Node2D/Sprite.flip_v = false
		
		#bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		#get_tree().get_root().add_child(bullet_instance)
		#if (isShooting == false):
			#$Node2D/Sprite.flip_h = false
			#$Node2D/Sprite.flip_v = false
	if Global.player_direction == "1":
		pass
		#$Node2D/Sprite.flip_h = true
#		bullet_speed = 500
#		print('FIRE!')
#		print(Global.player_direction)
#		isShooting = true 
#		bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position()
#		#bullet_instance.position = $Muzzle.get_global_position()
#		bullet_instance.rotation_degrees = rotation_degrees
#		look_at(get_global_mouse_position())
#		#$Node2D/Sprite.flip_h = true
#		$Node2D/Sprite.flip_v = true
#		$Node2D/Sprite/Mods/Silencer2.flip_h = true
#		$Node2D/Sprite/Mods/Silencer2.position = Vector2(48,5)
#		#$M4A1Sprite.flip_h = true
#		#$M4A1Sprite.flip_v = true
#		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
#		if (isShooting == false):
			#$Node2D/Sprite.flip_v = false
			#$Node2D/Sprite.flip_v = true
#			$Node2D/Sprite/Mods/Silencer2.flip_h = true
#			$Node2D/Sprite/Mods/Silencer2.position = Vector2(48,5)
	if Global.player_direction == "2":
		pass
#		bullet_speed = 500
#		print('FIRE!')
#		print(Global.player_direction)
#		isShooting = true 
#		bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position()
#		bullet_instance.rotation_degrees = rotation_degrees + (270 / PI)
#		look_at(get_global_mouse_position())
#		bullet_instance.apply_impulse(Vector2(), Vector2(0, bullet_speed).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
		
	if Global.player_direction == "3":
		pass
#		bullet_speed = -500
#		print('FIRE!')
#		print(Global.player_direction)
#		isShooting = true 
#		bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position() + Vector2(0,0)
#		bullet_instance.rotation_degrees = rotation_degrees + (-270 / PI)
#		look_at(get_global_mouse_position())
#		bullet_instance.apply_impulse(Vector2(), Vector2(0, bullet_speed).rotated(rotation))
#		get_tree().get_root().add_child(bullet_instance)
func _miningDrills_Animation():
	if parent_velocity != Vector2.ZERO:
		animationTree.set("parameters/IdleMiningDrill/blend_position", parent_velocity.normalized())
		animationState.travel("IdleMiningDrill")
		if isUsing:
			if Global.player_direction == "0":#right
				$AnimationPlayer.play("Drilling-right")
			if Global.player_direction == "1":#left
				$AnimationPlayer.play("Drilling-left")
			if Global.player_direction == "2":#down
				$AnimationPlayer.play("Drilling-down")
			if Global.player_direction == "3":#up
				$AnimationPlayer.play("Drilling-up")
			else:
				animationTree.set("parameters/IdleMiningDrill/blend_position", parent_velocity.normalized())
				animationState.travel("IdleMiningDrill")
				
func _guns_animation():
	if parent_velocity != Vector2.ZERO:
		animationTree.set("parameters/IdleMiningDrill/blend_position", parent_velocity.normalized())
		animationState.travel("IdleMiningDrill")
		if isUsing:
				animationState.travel("Drilling")
				animationTree.set("parameters/Drilling/blend_position", parent_velocity.normalized())
		#else:
			#animationTree.set("parameters/IdleM4A1/blend_position", parent_velocity.normalized())
	#else:
		#animationState.travel("IdleM4A1")
func toggle_lazer():
	var player = playerPath.instance()
	var lazer_attachment = $Node2D/Sprite/Mods/LazerBeam# this one doesnt spamm cannot fine lazer beam
	#var lazer_attachment = get_node("Position2D/Weapons/M4A1/LazerBeam")
	if Input.is_action_just_pressed("Lazer"):
		#if hasWeapon:
		print("hasWeapon")
		isLazer = !isLazer
		if isLazer:
			lazer_attachment.visible = true
			#isLazer = true
			print('lazer true')
		else:
			lazer_attachment.visible = false
			#isLazer = false
			print('lazer false')
