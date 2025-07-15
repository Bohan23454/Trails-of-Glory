extends Area2D

class_name player

# Learning this
@onready var muzzle4: Marker2D = $"Muzzle 4"
@onready var muzzle5: Marker2D = $"Muzzle 5"
@onready var spawner_component: Node2D = $SpawnerComponent
# https://www.youtube.com/watch?v=eq-UConTTuo&list=PL9FzW-m48fn09w6j8NowI_pSBVcsb3V78&index=2 Dumbass
@onready var laser_prefab = preload("res://Prefabs/laser.tscn")

signal player_killed

signal player_upgrade

var year = 41
var acc_speed = 0
var topspeed = 0
var shoottime = 0.2
var currentshoottime = 0
var upgradetimes = 0
var laser_speed = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if year == 40:
		topspeed = 0
	if year == 41:
		topspeed = 640
		acc_speed = 1.01
	if year == 42:
		topspeed = 0
	if year == 43:
		topspeed = 0
	if year == 44:
		topspeed = 0
	if year == 45:
		topspeed = 0
	if Input.is_action_pressed("player_decc") and position.y < 848:
		position.y += acc_speed * 3
	if Input.is_action_pressed("player_acc") and position.y > topspeed:
		position.y -= acc_speed
	if Input.is_action_pressed("player_right") and position.x < 592:
		position.x += 8
	if Input.is_action_pressed("player_left") and position.x > 112:
		position.x -= 8
	currentshoottime += delta
	if upgradetimes > 10 and Input.is_action_pressed("player_shoot") and currentshoottime > shoottime:
		var laser = laser_prefab.instantiate()
		laser.speed = laser_speed
		laser.position = position
		get_parent().add_child(laser)
		currentshoottime = 0.05 + 0.001 * upgradetimes
	if upgradetimes > 1 and Input.is_action_pressed("player_shoot") and currentshoottime > shoottime:
		var laser = laser_prefab.instantiate()
		laser.speed = laser_speed
		laser.position = position
		get_parent().add_child(laser)
		currentshoottime = 0 + 0.005 * upgradetimes
	if upgradetimes == 1 and Input.is_action_pressed("player_shoot") and currentshoottime > shoottime:
		var laser = laser_prefab.instantiate()
		laser.speed = laser_speed
		laser.position = position
		get_parent().add_child(laser)
		currentshoottime = 0
	if Input.is_action_just_pressed("player_shoot"):
		spawner_component.spawn(muzzle4.global_position)
		spawner_component.spawn(muzzle5.global_position)

func _on_area_entered(area: Area2D) -> void:
	if area is enemylaser:
		player_killed.emit()
		queue_free()
	if area is enemyarea:
		player_killed.emit()
		queue_free()
	if area is boss:
		player_killed.emit()
		queue_free()
	if area is bosslaser:
		player_killed.emit()
		queue_free()
	if area is upgradecannon:
		player_upgrade.connect(_on_player_upgrade)
		player_upgrade.emit()

func _on_player_killed() -> void:
	$"../RestartTimer".start()
	pass
	
func _on_player_upgrade() -> void:
	upgradetimes += 1 
	
	
