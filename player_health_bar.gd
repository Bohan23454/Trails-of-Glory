extends TextureProgressBar
@export var player: player


func update():
	value = player.current_health
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.player_damaged.connect(update)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
