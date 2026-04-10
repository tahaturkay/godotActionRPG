extends CharacterBody2D


const speed = 100.0
const rollSpeed = 125.0

var input_vector: = Vector2.ZERO
var last_input_vector: = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree #command+sol click ile animationTree'yi buraya attık
var playback: AnimationNodeStateMachinePlayback #onready olsaydı animation_tree hazır olmadan bunu açmaya çalışıcaktı
func _ready() -> void: 
	animation_tree.active = true 
	playback = animation_tree.get("parameters/StateMachine/playback")

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node() # State string olarak döndürülüyor 
	
	"""
	# match ile çoklu koşul kontrolü yapılabilir if-else'den ziyade
	match [current_state, is_on_floor()]:
	    [State.IDLE, true]:
	        print("Yerde duruyor")
	    [State.RUN, true]:
	        print("Yerde koşuyor")
	    [State.JUMP, false]:
	        print("Havada zıplıyor")
	========================================
	match current_state: # Birden fazla state kontrolü
    State.IDLE, State.RUN:
        # Hem IDLE hem de RUN durumunda çalışır
        check_for_jump_input()
    State.ATTACK:
        attack_enemy()
	"""
	match state: 
		"MoveState": move_state(delta) # AnimationTree'de "MoveState" içindeysek eğer.
		"AttackState":move_state(delta) ## geçici olarak yazdım düzelticem
		"RollState": roll_state(delta)
			
			
func move_state(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector != Vector2.ZERO: # Herhangi bir move inputu girildiyse
		last_input_vector = input_vector # En son hangi yöne dönük olduğumuzu kaydettik (Roll direction'ı için kullanıcaz)
		var direction_vector = Vector2(input_vector.x, -input_vector.y) # Hareket için daire çiziyoruz her yere eşit hızda gitmiş oluyoruz.
		_update_blend_positions(direction_vector) # Blend position "direction_vector"e göre güncelleniyor
	
	if Input.is_action_just_pressed("attack"): # Attack inputu girildiyse
		playback.travel("AttackState") # AttackState'ye geçiyoruz.
	
	if Input.is_action_just_pressed("roll"): # Roll inputu girildiyse
		playback.travel("RollState") # RollState'ye geçiyoruz.
	
	velocity = input_vector * speed # Hız güncellemesi
	move_and_slide()
func roll_state(delta: float) -> void:
	velocity = last_input_vector.normalized() * rollSpeed
	move_and_slide()
func _update_blend_positions(direction_vector: Vector2) -> void: # Gelen directiovector'e göre tüm blend_position'lar güncelleniyor.
		animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position",direction_vector) #Animationdaki blend positionu güncelledik
		animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position",direction_vector) #Blend position stand için güncellendi
		animation_tree.set("parameters/StateMachine/AttackState/blend_position", direction_vector) # Blend position attack için güncellendi
		animation_tree.set("parameters/StateMachine/RollState/blend_position", direction_vector)
