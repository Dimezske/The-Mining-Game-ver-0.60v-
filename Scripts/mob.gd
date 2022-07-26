extends KinematicBody2D

export var min_speed = 150.0
export var max_speed = 250.0

const SPEED= 200

enum {
	MOVE,
	ATTACK
}
var state = MOVE
var player = null
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
func _ready():
	animationTree.active = true

func _physics_process(_delta):
	match state:
		MOVE:
			move_state()
			
		ATTACK:
			attack_state()
	
		
func move_state():
	if player:
		var player_direction = (player.get_position() - self.position).normalized()
		var _return_vector = move_and_slide(SPEED * player_direction)
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			
		
		if _return_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", player_direction)
			animationTree.set("parameters/Walk/blend_position", player_direction)
			animationTree.set("parameters/Attack/blend_position", player_direction)
			animationState.travel("Walk")
		else:
			animationState.travel("Idle")
			
	
		
func attack_state():
	animationState.travel("Attack")
func attack_animation_finished():
	state = MOVE
func _on_DetectPlayer_body_entered(body):
	if body.name == "Player":
		player = body
func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		player = null
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_DetectAttack_body_entered(body):
	if body.name == "Player":
		state = ATTACK
		$AnimatedSprite.playing = true

func _on_Timer_timeout():
	state = MOVE

func create_blood_effect():
	if Input.is_action_just_pressed("use"):
		var BloodEffect = load("res://Assets/Effects/BloodEffect.tscn")
		var bloodEffect = BloodEffect.instance()
		var world = get_tree().current_scene
		print(bloodEffect)
		world.add_child(bloodEffect)
		bloodEffect.global_position = global_position
		
func _on_Hurtbox_area_entered(area):
	create_blood_effect()
	queue_free()
