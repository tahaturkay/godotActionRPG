extends CharacterBody2D
const speed = 30.0

@export var range: = 128

@onready var animation_tree: AnimationTree = $AnimationTree # Accessing animationTree node
@onready var sprite_2d: Sprite2D = $Sprite2D # Accessing Sprite2D node
#var playback: AnimationNodeStateMachinePlayback #onready olsaydı animation_tree hazır olmadan bunu açmaya çalışıcaktı
@export var player: Player # Globel scope'de type olarak oluşturulan player'i düşmanımıza inspectordan atayabiliyoruz world sahnesinde
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
@onready var ray_cast_2d: RayCast2D = $RayCast2D


"""func _ready() -> void: 
	animation_tree.active = true 
	playback = animation_tree.get("parameters/StateMachine/playback") # Animation_tree deki statemachine içindeki stateler'i playback kapsıyor
"""
func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()

	match state:
		"Idle": pass
		"Chase":
			var player = get_player()
			if player is Player:
				velocity = global_position.direction_to(player.global_position) * speed # direction_to bize normalized vector verir
				sprite_2d.scale.x = sign(velocity.x)
			else:
				velocity = Vector2.ZERO
			
			move_and_slide()
func get_player() -> Player:
	return get_tree().get_first_node_in_group("player")

func is_player_in_range() -> bool:
	var result = false
	var player: = get_player()
	if player is Player: # if player alive (if there is a player then player is exist)
		var distance_to_player = global_position.distance_to(player.global_position)
		if distance_to_player < range:
			result = true
	return result

func can_see_player() -> bool:
	if not is_player_in_range(): return false
	var player: = get_player()
	ray_cast_2d.target_position = player.global_position - global_position
	var has_los_to_player: = not ray_cast_2d.is_colliding()
	return has_los_to_player
	
	
