extends Area2D

class_name laser

@export var speed = 25
@onready var laser_animation = $laser_animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	laser_animation.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed

func _on_area_entered(area) -> void:
	if area is enemyarea:
		queue_free()
	if area is boss:
		queue_free()
	if area is bosslaser:
		queue_free()

func _on_timer_timeout():
	queue_free()
