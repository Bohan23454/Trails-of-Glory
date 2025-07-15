extends Node2D

@onready var enemy_prefab = preload("res://Prefabs/enemy.tscn")
@onready var boss_prefab = preload("res://Prefabs/boss.tscn")
@onready var Upgradecannon_prefab = preload("res://Prefabs/upgradecannon.tscn")
@onready var Upgradebullet_prefab = preload("res://Prefabs/bulletupgrade.tscn")

var score = 0
var cannonupgradefactor = 0
var pause = false
var boss_spawned = 0

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
		boss_spawned = 0
	if score % 100 == 0 and score != 0 and boss_spawned == 0:
		var boss = boss_prefab.instantiate()
		var random_y = randi_range(30, 610)
		boss.position = Vector2(1300, random_y)
		boss.boss_killed.connect(_on_boss_killed)
		add_child(boss)
		boss_spawned += 1

func _on_enemy_timer_timeout():
	var enemy = enemy_prefab.instantiate()
	var random_y = randi_range(30, 610)
	enemy.position = Vector2(1300, random_y)
	enemy.enemy_killed.connect(_on_enemy_killed)
	add_child(enemy)

func _on_enemy_timer_2_timeout() -> void:
	if score > 50:
		var enemy = enemy_prefab.instantiate()
		var random_y = randi_range(30, 610)
		enemy.position = Vector2(1300, random_y)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
	else:
		pass

func _on_enemy_timer_3_timeout() -> void:
	if score > 100:
		var enemy = enemy_prefab.instantiate()
		var random_y = randi_range(30, 610)
		enemy.position = Vector2(1300, random_y)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
	else:
		pass

func _on_enemy_timer_4_timeout() -> void:
	if score > 200:
		var enemy = enemy_prefab.instantiate()
		var random_y = randi_range(30, 610)
		enemy.position = Vector2(1300, random_y)
		enemy.enemy_killed.connect(_on_enemy_killed)
		add_child(enemy)
	else:
		pass

func _update_ui():
	$Game_ui/ScoreLabel.text = "Score: " + str(score)
	
func _on_boss_killed():
	score += 10
	_update_ui()
	
func _on_enemy_killed(enemyposition):
	var r = randi_range(1, 20)
	if r == 1:
		var upgradecannon = Upgradecannon_prefab.instantiate()
		upgradecannon.position = enemyposition
		add_child(upgradecannon)
	if r == 20:
		var upgradebullet = Upgradebullet_prefab.instantiate()
		upgradebullet.position = enemyposition
		add_child(upgradebullet)
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
