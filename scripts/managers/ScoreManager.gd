extends Node


# Called when the node enters the scene tree for the first time.



var score1 := 0
var score2 := 0
var score: int = 0
@onready var player_score:= get_tree().current_scene.get_node("Score")



func add_score(points: int):
	score += points
	print("Score:", score)
	player_score.text = "%d" % score


func _process(delta):
	pass


