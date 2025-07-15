extends Area2D

class_name boss

signal boss_killed
var health = 100

@export var speed = 1.5

@onready var bosslaser_prefab = preload("res://Prefabs/bosslaser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/Health_bar.value = health
	$Label/Health_bar.max_value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.x -= speed
	if health == 0:
		boss_killed.emit()
		queue_free()

func _on_area_entered(area) -> void:
	if area is laser:
		health -= 10
		$Label/Health_bar.value = health

func _on_bosstimer_timeout() -> void:
	var position_x = position.x
	var random_y = randi_range(-62, 62)
	var position_y = position.y + random_y
	var bosslaser = bosslaser_prefab.instantiate()
	bosslaser.position = Vector2(position_x, position_y)
	get_parent().add_child(bosslaser)
