#extends Node2D
#class_name Weapon
#onready var playerPath = load("res://Scenes/Player.tscn")
#onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
#onready var hitbox: Area2D = get_node("Node2D/Sprite/Hitbox")
#const M4A1_bulletPath = preload("res://Scenes/Bullet.tscn")
## true/false  on the ground
#export(bool) var on_floor: bool = true
#var parent_velocity = Vector2()
#var velocity = Vector2()
#var player_in_range : bool
#var player_picked_up : bool
#var hasWeapon : bool = false
#var bullet_speed
#var negative_bullet_speed = -500
## Attachment Mods
#var hasAttachedMod1: bool
#var hasAttachedMod2: bool
#var hasAttachedMod3: bool
#var hasAttachedMod4: bool
#var hasAttachedMod5: bool
#var isHolding: bool
#var isShooting : bool
#var isLazer : bool # detect on/ off
#
#onready var animationPlayer = $AnimationPlayer
#onready var animationTree = $AnimationTree
#onready var animationState = animationTree.get("parameters/playback")
#var item_name
#var player = null
#var being_picked_up = false
#func _ready():
#	if Global.playerNode.weapon["M4"]:
#		item_name = "M4"
#func _physics_process(_delta):
#	if Global.playerNode.isHoldingWeapon:
#		isEquiped()
#	if Input.is_action_just_pressed("interact"):
#		if player_picked_up == true:
#			player_picked_up = false
#		else:
#			if player_in_range == true:
#				player_picked_up = true
#				print(player_picked_up)
#				isHolding = true
#	if being_picked_up == false:
#		pass
#	else:
#		PlayerInventory.add_item(item_name, 1)
#		queue_free()
#func isEquiped():
#	_guns_input()
#	_assault_Rifle_Animation()
#	toggle_lazer()
##	hasAttachedMod1 = true
##	hasAttachedMod2 = true
#func init(item):
#	if item_name == "M4":
#		pass
#func pick_up_item(body):
#	player = body
#	being_picked_up = true
#func _guns_input():
#	if Input.is_action_just_pressed("fire"):
#		if $M4A1_Shoot_Sound.playing == false:
#			$M4A1_Shoot_Sound.play()
#			isShooting = true
#			assaultRifle_fire() # == null
#	if Input.is_action_pressed("fire"):
#		if $M4A1_Shoot_Sound.playing == false:
#			$M4A1_Shoot_Sound.play()
#			isShooting = true
#			assaultRifle_fire() # == null
#	else:
#		isShooting = false
#func assaultRifle_mods():
#	if hasAttachedMod1 == true:
#		$Node2D/Sprite/Mods/Silencer2.visible = true
#	if hasAttachedMod2 == true:
#		$Node2D/Sprite/Mods/LazerGreen.visible = true
#	else:
#		$Node2D/Sprite/Mods/Silencer2.visible = false
#		$Node2D/Sprite/Mods/LazerGreen.visible = false
##Shooting method
#func assaultRifle_fire():
#	var bullet_instance = M4A1_bulletPath.instance()
#	bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position()
#	bullet_instance.rotation_degrees = rotation_degrees
#	isShooting = true
#	bullet_speed = 500
#	var impulse_dir : Vector2
#	match int(Global.player_direction):
#		0: # Right
#			impulse_dir = Vector2(bullet_speed, 0)
#			print("right")
#		1: # Left
#			if Global.player_direction == "1":
#				impulse_dir = Vector2(negative_bullet_speed, 0)
#				print("left")
#		2: # Down
#			bullet_instance.rotation_degrees += (270 / PI)
#			impulse_dir = Vector2(0, bullet_speed)
#		3: # Up
#			bullet_instance.position += Vector2(0,0)
#			bullet_instance.rotation_degrees += (-270 / PI)
#			impulse_dir = Vector2(0, -bullet_speed)  
#	bullet_instance.apply_impulse(Vector2(), impulse_dir.rotated(rotation))
#	get_tree().get_root().add_child(bullet_instance)
##Assault Rifle Animations
#func _assault_Rifle_Animation():
#	if Global.playerNode.isHoldingWeapon:
#		if parent_velocity != Vector2.ZERO:
#			animationTree.set("parameters/IdleM4A1/blend_position", parent_velocity.normalized())
#			animationState.travel("IdleM4A1")
#			print(animationState.travel("IdleM4A1"))
#			if isShooting:
#				print(isShooting)
#				if item_name == "M4":
#					if Global.player_direction == "0":#right
#						$AnimationPlayer.play("Shooting_M4A1-right")
#					if Global.player_direction == "1":#left
#						$AnimationPlayer.play("Shooting_M4A1-left")
#					if Global.player_direction == "2":#down
#						$AnimationPlayer.play("Shooting_M4A1-down")
#					if Global.player_direction == "3":#up
#						$AnimationPlayer.play("Shooting_M4A1-up")
#					else:
#						animationTree.set("parameters/IdleM4A1/blend_position", parent_velocity.normalized())
#						animationState.travel("IdleM4A1")
## Toggle use of the laser sight
#func toggle_lazer():
#	var lazer_attachment = $Node2D/Sprite/Mods/LazerBeam
#	if Input.is_action_just_pressed("Lazer"):
#			isLazer = !isLazer
#			if isLazer:
#				lazer_attachment.visible = true
#				print('lazer true')
#			else:
#				lazer_attachment.visible = false
#				print('lazer false')
##number of problems with the m4
##1) not shooting strengthfully enough(shoots on a gravity curve)theres not enough power
##2) the gun isnt aiming to the mouse position  for left and right or up and down
##3) muzzleflash keeps firing
##4) press e adds a new iteration of the gun into the inventory
