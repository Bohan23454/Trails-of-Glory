extends Area2D

class_name enemyarea

signal enemy_killed

@export var speed = 3

@onready var enemylaser_prefab = preload("res://Prefabs/enemylaser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position.x -= speed


func _on_area_entered(area) -> void:
	if area is laser:
		enemy_killed.emit(global_position)
		queue_free()

func _on_enemylasertimer_timeout():
	var enemylaser = enemylaser_prefab.instantiate()
	enemylaser.position = position
	get_parent().add_child(enemylaser)
