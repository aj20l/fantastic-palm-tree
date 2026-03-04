extends Area2D
@export var EnemyScene: PackedScene
@export var horizontal_speed: float = 600.0
@export var float_speed: float = 100.0
@export var horizontal_time: float = 0.3
@export var lifetime: float = 3.0
@export var trapped_enemy: CharacterBody2D= null
signal bubble_popped(points: int)

var dir: int = 1
var float_up: bool = false

var _horizontal_timer: float = 0.0
var _lifetime_timer: float = 0.0


func _ready():
	
	_horizontal_timer = horizontal_time
	_lifetime_timer = lifetime
	body_entered.connect(_on_body_entered)


func _process(delta):

	# Lifetime countdown
	_lifetime_timer -= delta
	if _lifetime_timer <= 0.0:
		if trapped_enemy:
			trapped_enemy.release()
		queue_free()

		return

	# Horizontal phase
	if not float_up:
		position.x += dir * horizontal_speed * delta

		_horizontal_timer -= delta
		if _horizontal_timer <= 0.0:
			float_up = true

	# Floating phase
	else:
		position.y -= float_speed * delta



func _on_body_entered(body):
	if trapped_enemy != null:
		return  
	
	if body.has_method("set_trapped"):
		trapped_enemy = body
		body.set_trapped()
		

		#get_tree().current_scene.remove_child(self)
		#self.queue_free()
	pass # Replace with function body.


func _physics_process(delta):
	if trapped_enemy:
		trapped_enemy.global_position = global_position





func _on_player_entered(body):
	$CollisionShape2D.disabled=true
	if body.name == "Player" and trapped_enemy:
		emit_signal("bubble_popped",100)
		trapped_enemy.die()
		queue_free()
		
		print("asdasdsads")
		
	
	pass # Replace with function body.
