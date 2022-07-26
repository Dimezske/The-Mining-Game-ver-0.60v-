extends KinematicBody2D

export var min_speed = 50.0
export var max_speed = 150.0

const SPEED= 200

enum {
	MOVE,
	ATTACK
}
var state = MOVE
var Character = null
var direction = Vector2.RIGHT
var last_direction = Vector2(0, 1)
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var rng = RandomNumberGenerator.new()
func _ready():
	animationTree.active = true

func _physics_process(delta):
	var player = get_tree().root.get_node("/root/PlayerPath")
	rng.randomize()
	direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
	match state:
		MOVE:
			move_state()
			move(delta)
			if direction == Vector2.RIGHT:
				$AnimationPlayer.play("walk-right")
			if direction == Vector2.LEFT:
				$AnimationPlayer.play("walk-left")
			if direction == Vector2.UP:
				$AnimationPlayer.play("walk-up")
			if direction == Vector2.DOWN:
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
		$AnimatedSprite.playing = true
func move(delta):
	position += direction * SPEED * delta
func choose(array):
	array.shuffle()
	return array.front()
func _on_Timer_timeout():
	state = MOVE

