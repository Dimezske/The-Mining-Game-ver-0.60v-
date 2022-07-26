extends KinematicBody2D

export var min_speed = 50.0
export var max_speed = 150.0

const SPEED= 100

enum {
	IDLE,
	NEW_DIRECTION,
	MOVE,
	ATTACK
}

var state = MOVE
var direction = Vector2.RIGHT
var Character = null
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		
		IDLE:
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.stop()
				$AnimationPlayer.play("idle-down")
			
		NEW_DIRECTION:
			direction = choose([Vector2.RIGHT, Vector2.UP,Vector2.LEFT, Vector2.DOWN])
			state = choose([IDLE, MOVE])
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.play("idle-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.play("idle-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.play("idle-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.play("idle-down")
		MOVE:
			move_state()
			move(delta)
			if direction == choose([Vector2.RIGHT]):
				$AnimationPlayer.play("walk-right")
			if direction == choose([Vector2.LEFT]):
				$AnimationPlayer.play("walk-left")
			if direction == choose([Vector2.UP]):
				$AnimationPlayer.play("walk-up")
			if direction == choose([Vector2.DOWN]):
				$AnimationPlayer.play("walk-down")
		ATTACK:
			attack_state()
	
		
func move_state():
	if Character:
		var player_direction = (Character.get_position() - self.position).normalized()
		var _return_vector = move_and_slide(SPEED * player_direction)
		
		for i in get_slide_count():
			var _collision = get_slide_collision(i)
			
		if _return_vector != Vector2.ZERO:
			animationTree.set("parameters/Idle/blend_position", player_direction)
			animationTree.set("parameters/Walk/blend_position", player_direction)
			#animationTree.set("parameters/Attack/blend_position", player_direction)
			animationState.travel("Walk")
		else:
			animationState.travel("Idle")

func attack_state():
	#animationState.travel("Attack")
	pass
func attack_animation_finished():
	state = MOVE
func _on_DetectPlayer_body_entered(body):
	if body.name == "Player":
		Character = body
		animationTree.active = true

func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		Character = null
		animationTree.active = false

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_DetectAttack_body_entered(body):
	if body.name == "Player":
		state = ATTACK

func move(delta):
	position += direction * SPEED * delta
	
func choose(array):
	array.shuffle()
	return array.front()

func _on_Timer_timeout():
		state = choose([IDLE, NEW_DIRECTION, MOVE])
		$Timer.wait_time = choose([0.5, 1, 1.5])

func create_blood_effect():
	if Input.is_action_just_pressed("use"):
		var BloodEffect = load("res://Assets/Effects/BloodEffect.tscn")
		var bloodEffect = BloodEffect.instance()
		var world = get_tree().current_scene
		print(bloodEffect)
		world.add_child(bloodEffect)
		bloodEffect.global_position = global_position
		
func _on_Hurtbox_area_entered(_area):
	create_blood_effect()
	queue_free()
