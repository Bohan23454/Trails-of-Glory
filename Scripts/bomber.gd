extends Node2D

signal bomber_killed

@onready var bomber_animation = $bomberarea/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomber_animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
