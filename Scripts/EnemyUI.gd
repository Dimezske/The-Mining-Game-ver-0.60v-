extends Panel

#onready var enemy_portrait: TextureRect
#onready var enemy_name: Label
onready var enemy_portrait = $TextureRect
onready var enemy_name : Label = $EnemyName
onready var enemy_health = $HealthContainer/Health/HealthBar

func _ready():
#	enemy_portrait = $TextureRect
#	enemy_name = $EnemyName
	EventBus.connect("player_detected", self, "_on_Enemy_player_detected") # <-- Breakpoint here
	# using an event bus approach to remove reference problems between the enemy and the UI, this makes things easier
	EventBus.connect("player_exited", self, "_on_Enemy_player_exited") 
	
	EventBus.connect("show_ui_for_enemy", self, "_on_Enemy_player_detected")
	EventBus.connect("hide_ui_for_enemy", self, "_on_Enemy_player_exited")
	self.visible = false
	
func _on_Enemy_player_detected(detector):
	enemy_name.text = detector.enemy_name 
	enemy_portrait.texture = detector.enemy_texture
	enemy_health.update_max_health(detector.max_health)
	enemy_health.update_health(detector.health)
	self.visible = true
	#NPCS
	if enemy_name.text == "(TRT)Tactical Response Unit":
		enemy_portrait.rect_scale = Vector2(1,1)
		enemy_portrait.rect_position = Vector2(45,22.5)
	if enemy_name.text == "(TRT)Tactical*CBRN* Response Unit":
		enemy_portrait.rect_scale = Vector2(1,1)
		enemy_portrait.rect_position = Vector2(45,22.5)
	#ENEMIES
	if enemy_name.text == "Black Ant":
		enemy_portrait.rect_scale = Vector2(3,3)
		enemy_portrait.rect_position = Vector2(45,45)
	if enemy_name.text == "Milk Snake":
		enemy_portrait.rect_scale = Vector2(1,1)
		enemy_portrait.rect_position = Vector2(22.5,45)
	if enemy_name.text == "":
		 self.visible = false

func _on_Enemy_player_exited(exited):
	self.visible = false
	pass
