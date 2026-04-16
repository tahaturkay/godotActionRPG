extends CharacterBody2D
@onready var animation_tree: AnimationTree = $AnimationTree # Accessing animationTree node
@onready var sprite_2d: Sprite2D = $Sprite2D # Accessing Sprite2D node
var playback: AnimationNodeStateMachinePlayback #onready olsaydı animation_tree hazır olmadan bunu açmaya çalışıcaktı
@export var player: Player # Globel scope'de type olarak oluşturulan player'i düşmanımıza inspectordan atayabiliyoruz world sahnesinde

func _ready() -> void: 
	animation_tree.active = true 
	playback = animation_tree.get("parameters/StateMachine/playback") # Animation_tree deki statemachine içindeki stateler'i playback kapsıyor

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	
	match state: 
		"Idle": pass 
		"Chase":pass
