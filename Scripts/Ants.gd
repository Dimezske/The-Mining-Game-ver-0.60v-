extends KinematicBody2D
class_name Ant
export var min_speed = 50.0
export var max_speed = 150.0

export(Texture) var enemy_texture = null
export(String) var enemy_name = "Black Ant"
# export variables can be set from the editor
export(Vector2) var enemy_texture_size = Vector2(50,50)

const SPEED = 100
onready var health = 10
onready var max_health = 10
enum {
	MOVE,
	ATTACK
}
var state = MOVE
var Character = null
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
	if Character:
		
		var player_direction = (Character.get_position() - self.position).normalized()
		var _return_vector = move_and_slide(SPEED * player_direction)
		
		for i in get_slide_count():
			var _collision = get_slide_collision(i)
			
		if _return_vector != Vector2.ZERO:
			animationTree.set("parameters/Ant_Idle/blend_position", player_direction)
			animationTree.set("parameters/Ant_Walk/blend_position", player_direction)
			#animationTree.set("parameters/Attack/blend_position", player_direction)
			animationState.travel("Ant_Walk")
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

func _on_Timer_timeout():
	state = MOVE


func _on_DetectPlayer_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("use"):
		EventBus.emit_signal("show_ui_for_enemy", self)
		get_tree().set_input_as_handled()
		
#	if event is InputEventMouseButton and Input.is_action_just_pressed("use"):
#		EventBus.emit_signal("enemy_clicked", self)
#		get_tree().set_input_as_handled()
