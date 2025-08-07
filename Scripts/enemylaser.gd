extends Area2D

class_name enemylaser

@export var speed = 12
@onready var die_timer = $Enemy_laser_die_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	die_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	move_local_x(speed)



func _on_enemy_laser_die_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is player:
		queue_free()
