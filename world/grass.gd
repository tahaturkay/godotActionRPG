extends Node2D
@export var area_2d: Area2D # option + drag ile Area2D'yi buraya attık.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered)


# Grass nodunda inspectorun sağındaki signalstan ekledik
# Amacı areaya girildiğinde notification yollaması
func _on_area_2d_area_entered(other_area_2D: Area2D) -> void:
	# print("Grass area entered")
	queue_free()

"""
Godotta signal-up / call-down mantığı var.
Signal-up burda olduğu gibi grass interactiona girdiğinde
child node'undan _on_area_2d_area_entered fonksiyonun signal'ı parentine gönderiyor
Ayrıyeten yukarda _ready içinde belirttiğimiz gibi kod ile de bağlayabiliriz (önerilen)

Playerde yaptığımız ise call-down. Parent'a yazdığımız script ile
child nodelere mesaj iletiyoruz.
"""
