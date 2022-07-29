extends StaticBody2D

export(Texture) var enemy_texture = null
export(String) var enemy_name = "(TRT)Tactical*CBRN* Response Unit"
# export variables can be set from the editor
export(Vector2) var enemy_texture_size = Vector2(50,50)

const SPEED = 100
onready var health = 150
onready var max_health = 150
enum{
	IDLE,
	NEW_DIRECTION,
	MOVE
}
var state = MOVE
var direction = Vector2.RIGHT
var Character = null

func _ready():
	pass
func _on_DetectPlayer_body_entered(body):
	if body.name == "Player":
		Character = body
		#animationTree.active = true
		EventBus.emit_signal("player_detected", self)
func _on_DetectPlayer_body_exited(body):
	if body.name == "Player":
		Character = null
		#animationTree.active = false
		EventBus.emit_signal("player_exited", self)
func _on_DetectPlayer_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed("use"):
		EventBus.emit_signal("show_ui_for_enemy", self)
		get_tree().set_input_as_handled()
