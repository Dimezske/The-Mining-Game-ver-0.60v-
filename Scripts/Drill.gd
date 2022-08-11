extends KinematicBody2D
class_name Drill , "res://Assets/Tools/drill1.png"

onready var drillEffects = $SplatterParticles
var parent_velocity = Vector2()
var velocity = Vector2()
var isDrilling : bool
var isLazer : bool

var item_name
var player = null
var being_picked_up = false

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	item_name = "MiningDrill Starter"
	
func _process(_delta):
		#look_at(get_global_mouse_position())
		if Global.isHoldingTool:
			_drills_input()
			_drills_animation()
		if being_picked_up == false:
			pass
		else:
			PlayerInventory.add_item(item_name, 1)
			queue_free()

func _drills_input():
	if Global.hasMiningDrill:
		if Input.is_action_just_pressed("use"):
			if $MiningDrill_Sound.playing == false:
				$MiningDrill_Sound.play()
				isDrilling = true
				drill() # == null
		if Input.is_action_pressed("use"):
			if $MiningDrill_Sound.playing == false:
				$MiningDrill_Sound.play()
				isDrilling = true
				drill() # == null
		else:
			isDrilling = false
			
func pick_up_item(body):
	player = body
	being_picked_up = true
	
func drill():
	if isDrilling:
		drillEffects.visible = true
	else:
		drillEffects.visible = false
#	var drill_effects_instance = drillEffects.instance()
#	print("Drilling")
#	print(Global.player_direction)
#	isDrilling = true 
#	drill_effects_instance.position = $DrillEnd.get_global_position()
#	get_tree().get_root().add_child(drill_effects_instance)
	
func _drills_animation():
	if parent_velocity != Vector2.ZERO:
		animationTree.set("parameters/IdleDrill/blend_position", parent_velocity.normalized())
		animationState.travel("IdleDrill")
		if isDrilling:
			animationState.travel("Drilling")
			animationTree.set("parameters/Drilling/blend_position", parent_velocity.normalized())
		else:
			animationTree.set("parameters/IdleDrill/blend_position", parent_velocity.normalized())
	else:
		animationState.travel("IdleDrill")
