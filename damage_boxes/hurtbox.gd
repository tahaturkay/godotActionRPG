class_name HurtBox extends Area2D # Custom node oluşturduk. Area2D'nin tüm özelliklerini içeriyor.

signal hurt(hitbox: HitBox)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area_2d: Area2D) -> void:
	if area_2d is not HitBox: return
	hurt.emit(area_2d)
