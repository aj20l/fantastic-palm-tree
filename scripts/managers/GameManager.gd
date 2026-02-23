extends Node


# Called when the node enters the scene tree for the first time.

var game_over := false
func _ready():
	$CanvasLayer/GameOver.visible=false




var score1 := 0
var score2 := 0
var score: int = 0
@onready var player_score:= $Score
@onready var score_label1 := $CanvasLayer/Player1Score
@onready var score_label2 := $CanvasLayer/Player2Score


func add_score(points: int):
	score += points
	print("Score:", score)

#func add_score(amount,node):
	##check for which area it is then do the eright add
	#if node == get_node("/root/Playfield/Player1_Zone"):
		#$Goal.play()
		#score1 += amount
		#score_label2.text = "%d" % score1
		#if score1==10:
			#end_game()
	#if node == get_node("/root/Playfield/Player2_Zone"):
		#$Goal.play()
		#score2 += amount
		#score_label1.text = "%d" % score2
		#if score2==10:
			#end_game()
		#
func _process(delta):
	if game_over and Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func end_game():
	game_over = true
	$CanvasLayer/GameOver.visible = true
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

	pass
