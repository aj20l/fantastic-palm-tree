extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"): 
		print("Asdasd")
		get_tree().change_scene_to_file("res://scenes/world/Level01.tscn")
