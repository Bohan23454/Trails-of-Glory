extends Area2D

class_name bosslaser

@onready var bosslaser_animation = $bosslaser_animation

@export var speed = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bosslaser_animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * 2

func _on_area_entered(area: Area2D) -> void:
	if area is laser:
		queue_free()
