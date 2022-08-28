extends KinematicBody2D
class_name Trm17
onready var playerPath = load("res://Scenes/Player.tscn")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var hitbox: Area2D = get_node("Node2D/Sprite/Hitbox")
const TRM17_bulletPath = preload("res://Scenes/Bullet.tscn")
# true/false  on the ground
export(bool) var on_floor: bool = true
var parent_velocity = Vector2()
var velocity = Vector2()
var player_in_range : bool
var player_picked_up : bool
var hasWeapon : bool = false
var bullet_speed
var negative_bullet_speed = -500
# Attachment Mods
var hasAttachedMod1: bool
var hasAttachedMod2: bool
var hasAttachedMod3: bool
var hasAttachedMod4: bool
var hasAttachedMod5: bool
var isHolding: bool
var isShooting : bool
var isLazer : bool # detect on/ off
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var item_name
var player = null
var being_picked_up = false

func _ready():
	if Global.playerNode.weapon["Trm17"]:
		item_name = "Trm17"
func _physics_process(_delta):
	if Global.playerNode.isHoldingWeapon:
		isEquiped()
	if Input.is_action_just_pressed("interact"):
		if player_picked_up == true:
			player_picked_up = false
		else:
			if player_in_range == true:
				player_picked_up = true
				print(player_picked_up)
				isHolding = true
	if being_picked_up == false:
		pass
	else:
		PlayerInventory.add_item(item_name, 1)
		queue_free()
	#velocity = move_and_slide(velocity, Vector2.UP)
func isEquiped():
	_guns_input()
	_assault_Rifle_Animation()
	toggle_lazer()
#	hasAttachedMod1 = true
#	hasAttachedMod2 = true
func init(item):
	if item_name == "Trm17":
		pass
func pick_up_item(body):
	player = body
	being_picked_up = true
func _guns_input():
	#look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire"):
		if $M4A1_Shoot_Sound.playing == false:
			$M4A1_Shoot_Sound.play()
			isShooting = true
			assaultRifle_fire() # == null
	if Input.is_action_pressed("fire"):
		if $M4A1_Shoot_Sound.playing == false:
			$M4A1_Shoot_Sound.play()
			isShooting = true
			assaultRifle_fire() # == null
	else:
		isShooting = false
func assaultRifle_mods():
	if hasAttachedMod1 == true:
		$Node2D/Sprite/Mods/Silencer2.visible = true
	if hasAttachedMod2 == true:
		$Node2D/Sprite/Mods/LazerGreen.visible = true
	else:
		$Node2D/Sprite/Mods/Silencer2.visible = false
		$Node2D/Sprite/Mods/LazerGreen.visible = false
#Shooting method
func assaultRifle_fire():
	var bullet_instance = TRM17_bulletPath.instance()
	bullet_instance.position = $Node2D/Sprite/Muzzle.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	isShooting = true
	bullet_speed = 500
	var impulse_dir : Vector2
	match int(Global.player_direction):
		0: # Right
			impulse_dir = Vector2(bullet_speed, 0)
			print("right")
		1: # Left
			if Global.player_direction == "1":
				impulse_dir = Vector2(negative_bullet_speed, 0)
				print("left")
		2: # Down
			bullet_instance.rotation_degrees += (270 / PI)
			impulse_dir = Vector2(0, bullet_speed)
		3: # Up
			bullet_instance.position += Vector2(0,0)
			bullet_instance.rotation_degrees += (-270 / PI)
			impulse_dir = Vector2(0, -bullet_speed)  
	bullet_instance.apply_impulse(Vector2(), impulse_dir.rotated(rotation))
	get_tree().get_root().add_child(bullet_instance)

#Assault Rifle Animations
func _assault_Rifle_Animation():
#	if Global.playerNode.current_weapon:
	if Global.playerNode.isHoldingWeapon:
		if parent_velocity != Vector2.ZERO:
			animationTree.set("parameters/IdleTRM17/blend_position", parent_velocity.normalized())
			animationState.travel("IdleTRM17")
			print(animationState.travel("IdleTRM17"))
			if isShooting:
				print(isShooting)
				if item_name == "Trm17":
					if Global.player_direction == "0":#right
						$AnimationPlayer.play("Shooting_TRM17-right")
					if Global.player_direction == "1":#left
						$AnimationPlayer.play("Shooting_TRM17-left")
					if Global.player_direction == "2":#down
						$AnimationPlayer.play("Shooting_TRM17-down")
					if Global.player_direction == "3":#up
						$AnimationPlayer.play("Shooting_TRM17-up")
					else:
						animationTree.set("parameters/IdleTRM17/blend_position", parent_velocity.normalized())
						animationState.travel("IdleTRM17")
# Toggle use of the laser sight
func toggle_lazer():
	var lazer_attachment = $Node2D/Sprite/Mods/LazerBeam
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
