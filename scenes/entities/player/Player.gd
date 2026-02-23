extends CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	lives=3
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var base_speed := 400
signal player_died
@export var gravity : float = 1200.0
@export var jump_velocity : float = -600.0
@export var lives : int
var max_lives : int = 10
var facing



	
func _physics_process(delta):
	var direction = Input.get_axis("move_left","move_right")
	if direction>0:
		facing=1
	else:
		facing=-1
	#print(direction)
	velocity.x = direction * base_speed
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_velocity


		move_and_slide()

	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		shoot(facing)
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()

		if body.is_in_group("Enemy"):
			take_damage(1)
	#print(global_position)


@export var Bubble: PackedScene

func shoot(direction):
	var bubble = Bubble.instantiate()
	bubble.global_position = global_position
	bubble.dir = direction 
	if bubble.dir == 0:
		bubble.dir = 1  # default right  standing still

	bubble.bubble_popped.connect(
	get_tree().current_scene.get_node("Score").add_score)
	get_tree().current_scene.add_child(bubble)

func take_damage(amount: int):
	lives -= amount
	print("Lives left:", lives)
#add i frames
	if lives <= 0:
		die()
		
func die():
	print("Player died")
	emit_signal("player_died")
	queue_free()


