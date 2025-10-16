extends Node

@export var main: main
var pause = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float) -> void:

	if Input.is_action_just_pressed("player_pause") and PauseManager.pause == true:
		
		PauseManager.pause = false
		await get_tree().create_timer(0.1).timeout
		get_tree().paused = false
	
		#main.PauseMenu.hide()
		

	if Input.is_action_just_pressed("player_pause") and PauseManager.pause == false:
		
		PauseManager.pause = true
		await get_tree().create_timer(0.1).timeout
		get_tree().paused = true

		#main.PauseMenu.show()
		
	
