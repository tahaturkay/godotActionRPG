extends Node2D
@export var area_2d: Area2D # option + drag ile Area2D'yi buraya attık.

# const grass_effect = preload("res://effects/grass_effect.tscn") # effects'teki grass effecte eriştik
@export var grass_effect: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered) #Areayı kod ile bağladık. Yukarıda sürükleyerek bağladığımız için debugger error veriyor. Güvenli olan kod ile bağlamak


# Grass nodunda inspectorun sağındaki signalstan ekledik
# Amacı areaya girildiğinde notification yollaması
func _on_area_2d_area_entered(other_area_2D: Area2D) -> void:
	# print("Grass area entered")
	var grass_effect_instance = grass_effect.instantiate() #Scene file'yi alıp node olarak instantiate ediyoruz
	get_tree().current_scene.add_child(grass_effect_instance) #Sahneye child node olarak ekliyoruz (world)
	grass_effect_instance.global_position = global_position # grass'ın global positionunu grass_effect'in pozisyonuna atıyoruz
	
	queue_free() # Ortadan kaldırıyor mevcut spriteyi

"""
Godotta signal-up / call-down mantığı var.
Signal-up burda olduğu gibi grass interactiona girdiğinde
child node'undan _on_area_2d_area_entered fonksiyonun signal'ı parentine gönderiyor
Ayrıyeten yukarda _ready içinde belirttiğimiz gibi kod ile de bağlayabiliriz (önerilen)

Playerde yaptığımız ise call-down. Parent'a yazdığımız script ile
child nodelere mesaj iletiyoruz.
"""
