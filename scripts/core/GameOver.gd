extends Control

func _ready():
	print("dsfdsf")
	

func _input(event):
	$GameOver.visible=true
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/world/Level01.tscn")
