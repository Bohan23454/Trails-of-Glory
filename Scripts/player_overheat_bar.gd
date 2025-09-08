
extends TextureProgressBar
@export var player: player
@export var red_texture = preload("res://skins/healbar player/overheatcirclebar2.svg")

func update():
	value = player.current_overheat
	
func update_red():
	texture_over = red_texture

func update_un_red():
	texture_over = null

func _ready() -> void:
	texture_over = null
	player.overheat.connect(update)
	player.cooling.connect(update)
	player.red_overheated.connect(update_red)
	player.un_red_overheated.connect(update_un_red)
	update()

	
