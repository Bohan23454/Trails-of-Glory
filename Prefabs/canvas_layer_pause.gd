extends CanvasLayer

func _process(delta: float) -> void:
	
	if PauseManager.pause == false:
		visible = false
	
	if PauseManager.pause == true:
		visible = true
