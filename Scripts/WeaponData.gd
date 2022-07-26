extends Node

var ammoAmount: int
var ammoMagazineAmount: int
var bulletSpread: Array = [0,0]
var bullet_speed = -500
var fire_rate: float
var damage: float
var freeze: float

# Attachment Mods
var hasAttachedMod1: bool
var hasAttachedMod2: bool
var hasAttachedMod3: bool
var hasAttachedMod4: bool
var hasAttachedMod5: bool
var isShooting : bool
var isLazer : bool # detect on/ off
#onready var animationPlayer = $AnimationPlayer
#onready var animationTree = $AnimationTree
#onready var animationState = animationTree.get("parameters/playback")

var item_name
var AssaultRifles
var SecondarySideArms

var weaponList = {
	AssaultRifles: ['M4'],
	SecondarySideArms: ['Tac1']
}
func _ready():
	pass # Replace with function body.
