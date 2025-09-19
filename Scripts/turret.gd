extends Node2D
#var player: GameManager.player

@onready var bomber_spawner_component = $BomberSpawnerComponent
@onready var muzzle = $Muzzle
@export var bomber: bomber
var spawn_timed = 0

func _ready() -> void:
	GameManager.player.position_changed.connect(_on_player_moved)
	 
func _on_player_moved(pos: Vector2) -> void:
	if GameManager.player and is_instance_valid(GameManager.player):
		print("Player moved to:", pos)
		look_at(pos) 

func _process(delta: float) -> void:
	if GameManager.player and is_instance_valid(GameManager.player):
		look_at(GameManager.player.player_global_position)
	

func _on_turretshoottimer_timeout() -> void:
		bomber_spawner_component.spawn(muzzle.global_position)
		await get_tree().create_timer(0.15).timeout
		bomber_spawner_component.spawn(muzzle.global_position)
		await get_tree().create_timer(0.15).timeout
		bomber_spawner_component.spawn(muzzle.global_position)
		await get_tree().create_timer(0.15).timeout
		bomber_spawner_component.spawn(muzzle.global_position)
		await get_tree().create_timer(0.15).timeout
		bomber_spawner_component.spawn(muzzle.global_position)
		await get_tree().create_timer(0.15).timeout
