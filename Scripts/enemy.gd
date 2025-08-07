extends Node2D

signal enemy_killed

@export var speed = 3

@onready var enemylaser_prefab = preload("res://Prefabs/enemylaser.tscn")
@onready var enemy_animation = $Path2D/PathFollow2D/enemyarea/enemy_animation
@onready var enemy_spawner_component = $Path2D/PathFollow2D/enemyarea/EnemySpawnerComponent
@onready var muzzle1 = $"Path2D/PathFollow2D/enemyarea/Muzzle 1"
@onready var muzzle2 = $"Path2D/PathFollow2D/enemyarea/Muzzle 2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_animation.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Path2D/PathFollow2D.progress += 100 * _delta

func _on_enemylasertimer_timeout():
	enemy_spawner_component.spawn(muzzle1.global_position, muzzle1.global_rotation)
	enemy_spawner_component.spawn(muzzle2.global_position, muzzle2.global_rotation)
	await get_tree().create_timer(0.15).timeout
	enemy_spawner_component.spawn(muzzle1.global_position, muzzle1.global_rotation)
	enemy_spawner_component.spawn(muzzle2.global_position, muzzle2.global_rotation)
	await get_tree().create_timer(0.15).timeout
	enemy_spawner_component.spawn(muzzle1.global_position, muzzle1.global_rotation)
	enemy_spawner_component.spawn(muzzle2.global_position, muzzle2.global_rotation)
	await get_tree().create_timer(0.15).timeout

func _on_enemyarea_area_entered(area: Area2D) -> void:
	if area is laser:
		enemy_killed.emit(global_position)
		queue_free()
