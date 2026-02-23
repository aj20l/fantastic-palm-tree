extends Node

# Called when the node enters the scene tree for the first time.
var enemies_remaining := 0
func _ready():
	var all_enemies = get_tree().get_nodes_in_group("Enemy")
	enemies_remaining = all_enemies.size()
	
	# Connect signals for all enemies
	for enemy in all_enemies:
		enemy.enemy_defeated.connect(_on_enemy_defeated)

	$Player.player_died.connect(_on_player_died)
	pass # Replace with function body.

func _on_enemy_defeated():
	enemies_remaining -= 1
	print("Enemies left:", enemies_remaining)
	
	if enemies_remaining <= 0:
		print("Victory!")  # or show a UI
		get_tree().change_scene_to_file("res://scenes/screens/Victory.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func _on_player_died():
	get_tree().change_scene_to_file("res://scenes/screens/GameOver.tscn")
	





