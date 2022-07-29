extends KinematicBody2D

export var min_speed = 50.0
export var max_speed = 150.0
export(Texture) var enemy_texture = null
export(String) var enemy_name = "Milk Snake"
# export variables can be set from the editor
const SPEED= 200
onready var health = 35
onready var max_health = 35
enum {
	MOVE,
	ATTACK
}
var player
var playerPath = preload("res://Scenes/Player.tscn")
var state = MOVE
var Character = null

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
var rng = RandomNumberGenerator.new()

# Movement variables
export var speed = 25
var direction : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0

func _ready():
	animationTree.active = true
	player = playerPath.instance()
#	player = get_tree().root.get_node("/root/PlayerPath")
	rng.randomize()
	
func _physics_process(delta):
	
	
	match state:
		MOVE:
			var movement = direction * speed * delta
			var collision = move_and_collide(movement)
			if collision != null and collision.collider.name != "Player":
				direction = direction.rotated(rng.randf_range(PI/4, PI/2))
				bounce_countdown = rng.randi_range(2, 5)
			move_state()
			
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
		EventBus.emit_signal("player_detected", self)
func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		Character = null
		animationTree.active = false
		EventBus.emit_signal("player_exited", self)
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_DetectAttack_body_entered(body):
	if body.name == "Player":
		state = ATTACK
		$AnimatedSprite.playing = true
func move(delta):
	position += direction * SPEED * delta

func _on_Timer_timeout():
	# Calculate the position of the player relative to the skeleton
	var player_relative_position = player.position - position
	
	if player_relative_position.length() <= 16:
		# If player is near, don't move but turn toward it
		direction = Vector2.ZERO
		last_direction = player_relative_position.normalized()
	elif player_relative_position.length() <= 100 and bounce_countdown == 0:
		# If player is within range, move toward it
		direction = player_relative_position.normalized()
	elif bounce_countdown == 0:
		# If player is too far, randomly decide whether to stand still or where to move
		var random_number = rng.randf()
		if random_number < 0.05:
			direction = Vector2.ZERO
		elif random_number < 0.1:
			direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
	
	# Update bounce countdown
	if bounce_countdown > 0:
		bounce_countdown = bounce_countdown - 1


func _on_DetectPlayer_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("use"):
		EventBus.emit_signal("show_ui_for_enemy", self)
		get_tree().set_input_as_handled()
