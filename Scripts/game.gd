extends Node2D

class_name main

#https://www.youtube.com/watch?v=UEJcUnq2dfU

@onready var enemy_prefab = preload("res://Prefabs/enemy.tscn")
@onready var boss_prefab = preload("res://Prefabs/boss.tscn")
@onready var Upgradecannon_prefab = preload("res://Prefabs/upgradecannon.tscn")
@onready var Upgradebullet_prefab = preload("res://Prefabs/bulletupgrade.tscn")
@onready var bomber_prefab = preload('res://Prefabs/bomber.tscn')

var score = 0
var cannonupgradefactor = 0
var pause = false
var bomber_spawned = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	_update_ui()
	$PauseMenu.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if Input.is_action_just_pressed("player_pause") and pause == true:
		get_tree().paused = false
		$PauseMenu.hide()
		await get_tree().create_timer(0.5).timeout
		pause = false
	if Input.is_action_just_pressed("player_pause") and pause != true:
		get_tree().paused = true
		$PauseMenu.show()
		pause = true
	if score % 2 != 0:
		bomber_spawned = 0
	if score % 100 == 0 and score != 0 and bomber_spawned == 0:
		var bomber = bomber_prefab.instantiate()
		bomber.position = Vector2(0, 0)
		bomber.bomber_killed.connect(_on_bomber_killed)
		add_child(bomber)
		bomber_spawned += 1
 
func _on_enemy_timer_timeout():
	for i in range(2):
		var enemy_x = randi_range(-32, 32)
		var enemy_po1 = 128 + enemy_x
		var enemy_po2 = 296 + enemy_x
		var enemy_po3 = 464 + enemy_x
		var enemy_po4 = 592 + enemy_x
		#Leader's wingman
		var enemy = enemy_prefab.instantiate()
		#var random_x = randi_range(, 610)
		enemy.position = Vector2(enemy_po1, 0)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
		#Flying leader
		enemy = enemy_prefab.instantiate()
		enemy.position = Vector2(enemy_po2, 144)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
		#Leader of the second pair
		enemy = enemy_prefab.instantiate()
		enemy.position = Vector2(enemy_po3, 0)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
		#Second leader's wing man
		enemy = enemy_prefab.instantiate()
		enemy.position = Vector2(enemy_po4, -144)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
		await get_tree().create_timer(2.0).timeout

#func _on_enemy_timer_2_timeout() -> void:
	#if score > 50:
		#var enemy = enemy_prefab.instantiate()
		#var random_y = randi_range(30, 610)
		#enemy.position = Vector2(1300, random_y)
		#enemy.enemy_killed.connect(_on_enemy_killed)
		#add_child(enemy)
	#else:
		#pass

func _update_ui():
	$Game_ui/ScoreLabel.text = "Score: " + str(score)
	
func _on_boss_killed():
	score += 10
	_update_ui()
	
func _on_enemy_killed(enemyposition):
	var r = randi_range(1, 20)
	#if r == 1:
		#var upgradecannon = Upgradecannon_prefab.instantiate()
		#upgradecannon.position = enemyposition
		#add_child(upgradecannon)
	#if r == 20:
		#var upgradebullet = Upgradebullet_prefab.instantiate()
		#upgradebullet.position = enemyposition
		#add_child(upgradebullet)
	score += 1
	_update_ui()

func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_unpause_button_pressed() -> void:
	get_tree().paused = false
	$PauseMenu.hide()
	await get_tree().create_timer(0.5).timeout
	pause = false

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	await get_tree().create_timer(0.05).timeout
	pause = false
	$PauseMenu.hide()
	get_tree().reload_current_scene()


func _on_bomber_killed() -> void:
	score += 10
	_update_ui()
