extends Area2D

class_name upgradecannon

@export var speed = 3

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	position.x -= speed

func _on_area_entered(area: Area2D) -> void:
	if area is player:
		queue_free()
