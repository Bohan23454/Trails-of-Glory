extends TextureProgressBar
@export var player: player

func update():
	value = player.current_health
	
func _ready() -> void:
	player.player_damaged.connect(update)
	update()
