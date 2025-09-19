extends Area2D

class_name player

@onready var muzzle4: Marker2D = $"Muzzle 4"
@onready var muzzle5: Marker2D = $"Muzzle 5"
@onready var muzzle4_right: Marker2D = $"Muzzle 4 right"
@onready var muzzle5_right: Marker2D = $"Muzzle 5 right"
@onready var muzzle4_left: Marker2D = $"Muzzle 4 left"
@onready var muzzle5_left: Marker2D = $"Muzzle 5 left"
@onready var spawner_component: Node2D = $SpawnerComponent
# https://www.youtube.com/watch?v=eq-UConTTuo&list=PL9FzW-m48fn09w6j8NowI_pSBVcsb3V78&index=2
@onready var laser_prefab = preload("res://Prefabs/laser.tscn")
var player_health = 100
var current_health = player_health

#Animation
@onready var Spitfire_animation = $Spitfire
@onready var Spitfire_animation_right = $Spitfire_right
@onready var Spitfire_animation_left = $Spitfire_left
var right = false
var left = false
var right_left = false
#Animation

#Hitbox
@onready var Spitfire_hitbox = $Spitfire_hitbox
@onready var Spitfire_hitbox_right = $Spitfire_hitbox_right
@onready var Spitfire_hitbox_left = $Spitfire_hitbox_left
#Hitbox 
signal player_killed
signal player_damaged

# Gun overheat
signal red_overheated
signal un_red_overheated
signal overheat
signal cooling
var overheat_var = 0
var overheated = false
var current_overheat = overheat_var

signal player_upgrade

var year = 41
var acc_speed = 0
var topspeed = 0
var shoottime = 0.2
var currentshoottime = 0
var upgradetimes = 0
var laser_speed = 25

var player_global_position: Vector2
signal position_changed(global_position: Vector2)
var last_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.player = self
	Spitfire_animation.play()
	Spitfire_animation_right.play()
	Spitfire_animation_left.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if global_position != last_pos:
		last_pos = global_position
		emit_signal("position_changed", global_position)
	player_global_position = global_position
	
	# Health
	if player_health > 100:
		player_health = 100
		player_damaged.emit()
	
	# Turn
	right = false
	left = false
	right_left = false
	
	# Stats
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
	
	# Movements
	if Input.is_action_pressed("player_decc") and position.y < 848:
		position.y += acc_speed * 3
	if Input.is_action_pressed("player_acc") and position.y > topspeed:
		position.y -= acc_speed
	if Input.is_action_pressed("player_right") and position.x < 592 and right_left != true:
		right = true
		position.x += 8
	if Input.is_action_pressed("player_left") and position.x > 112 and right_left != true:
		left = true
		position.x -= 8
	if Input.is_action_pressed("player_right") and Input.is_action_pressed("player_left"):
		right_left = true
	currentshoottime += delta
	# if upgradetimes == 1 and Input.is_action_pressed("player_shoot") and currentshoottime > shoottime:
		# var laser = laser_prefab.instantiate()
		# laser.speed = laser_speed
		# laser.position = position
		# get_parent().add_child(laser)
		# currentshoottime = 1
	if Input.is_action_pressed("player_shoot") and overheated == false and currentshoottime > shoottime and right == false and left == false:
		spawner_component.spawn(muzzle4.global_position)
		spawner_component.spawn(muzzle5.global_position)
		currentshoottime = 0.1
		overheat.emit()
	if Input.is_action_pressed("player_shoot") and overheated == false and currentshoottime > shoottime and right == true and left == false:
		spawner_component.spawn(muzzle4_right.global_position)
		spawner_component.spawn(muzzle5_right.global_position)
		currentshoottime = 0.1
		overheat.emit()
	if Input.is_action_pressed("player_shoot") and overheated == false and currentshoottime > shoottime and right == false and left == true:
		spawner_component.spawn(muzzle4_left.global_position)
		spawner_component.spawn(muzzle5_left.global_position)
		currentshoottime = 0.1
		overheat.emit()
	if Input.is_action_pressed("player_shoot") and overheated == false and currentshoottime > shoottime and right_left == true:
		spawner_component.spawn(muzzle4.global_position)
		spawner_component.spawn(muzzle5.global_position)
		currentshoottime = 0.1
		overheat.emit()
	if right_left == true:
		Spitfire_animation.show()
		Spitfire_animation_right.hide()
		Spitfire_animation_left.hide()
		Spitfire_hitbox.disabled = false
		Spitfire_hitbox_right.disabled = true
		Spitfire_hitbox_left.disabled = true
	if right == false and left == false:
		Spitfire_animation.show()
		Spitfire_animation_right.hide()
		Spitfire_animation_left.hide()
		Spitfire_hitbox.disabled = false
		Spitfire_hitbox_right.disabled = true
		Spitfire_hitbox_left.disabled = true
	if right == true and right_left != true:
		await get_tree().create_timer(0.05).timeout
		Spitfire_animation.hide()
		Spitfire_animation_right.show()
		Spitfire_animation_left.hide()
		Spitfire_hitbox.disabled = true
		Spitfire_hitbox_right.disabled = false
		Spitfire_hitbox_left.disabled = true
	if left == true and right_left != true:
		await get_tree().create_timer(0.05).timeout
		Spitfire_animation.hide()
		Spitfire_animation_right.hide()
		Spitfire_animation_left.show()
		Spitfire_hitbox.disabled = true
		Spitfire_hitbox_right.disabled = true
		Spitfire_hitbox_left.disabled = false
	if player_health <= 0:
		queue_free()
		player_killed.emit()
	
	# Overheat
	if overheat_var >= 100:
		overheated = true

	


func _on_area_entered(area: Area2D) -> void:
	if area is enemylaser:
		player_health -= 5
		player_damaged.emit()
	if area is enemyarea:
		player_health -= 100
		player_damaged.emit()
	if area is boss:
		player_health -= 100
		player_damaged.emit()
	if area is bosslaser:
		player_health -= 100
		player_damaged.emit()
		
	#if area is upgradecannon:
		#player_upgrade.connect(_on_player_upgrade)
		#player_upgrade.emit()

func _on_player_killed() -> void:
	$"../RestartTimer".start()
	pass
	


func _on_player_damaged() -> void:
	current_health = player_health


func _on_regen_timer_timeout() -> void:
	print('regened')
	if player_health < 100:
		player_health += 10
		player_damaged.emit()
	if player_health >= 100:
		pass


func _on_overheat() -> void:
	current_overheat = overheat_var
	overheat_var += 5
	await get_tree().create_timer(2.5).timeout
	if overheat_var > 0 and overheat_var < 100 and overheated != true:
		for i in range(1):
			overheat_var -= 5
			cooling.emit()
	if overheat_var > 0 and overheat_var >= 100:
		red_overheated.emit()
		await get_tree().create_timer(3).timeout
		un_red_overheated.emit()
		for i in range(1):
			overheat_var -= 5
			cooling.emit()
		await get_tree().create_timer(2).timeout
		overheated = false




func _on_cooling() -> void:
	current_overheat = overheat_var
