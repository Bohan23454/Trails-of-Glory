extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Prefabs/game.tscn")
	pass



func _on_leave_pressed() -> void:
	get_tree().quit()
