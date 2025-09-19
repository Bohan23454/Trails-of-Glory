extends Node2D

class_name bomber

signal bomber_killed
var timeouted = false
var health = 100

@onready var bomber_animation = $Path2D/PathFollow2D/bomberarea/bomber_animation
@onready var health_bar = $Path2D/PathFollow2D/bomberarea/Label/bomber_health_bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomber_animation.play()
	health_bar.hide()
	$Path2D/PathFollow2D/bomberarea/Label/bomber_health_bar.value = health
	$Path2D/PathFollow2D/bomberarea/Label/bomber_health_bar.max_value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Path2D/PathFollow2D.progress += 100 * delta
	if health <= 0:
		bomber_killed.emit()
		queue_free()

	if timeouted != true:
		health = 100
	else:
		pass

func _on_bomberarea_area_entered(area) -> void:
	if area is laser:
		health -= 1
		$Path2D/PathFollow2D/bomberarea/Label/bomber_health_bar.value = health


func _on_start_timer_timeout() -> void:
	health_bar.show()
	timeouted = true
