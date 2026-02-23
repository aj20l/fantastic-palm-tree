extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity: float = 900.0

var direction: int = -1  # -1 = left, 1 = right
var state=1#active mode
@onready var ledge_ray: RayCast2D = $LedgeRay
@onready var sprite: Node2D = $Sprite2D  # change if using AnimatedSprite2D
signal enemy_defeated
var health := 1 

func _physics_process(delta):
	# Apply gravity

	if state == 1:
		if not is_on_floor():
			velocity.y += gravity * delta

	# Horizontal movement
		velocity.x = direction * speed

		move_and_slide()

	# --- Turn around on wall collision ---
		if is_on_wall():
			turn_around()
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var body = collision.get_collider()
#
		#if body.is_in_group("Enemy"):
			#$CollisionShape2D.disabled=true
	#  Turn around at ledge 
	#if is_on_floor() and not ledge_ray.is_colliding():
		#turn_around()


func turn_around():
	direction *= -1
	
	# Flip sprite
	sprite.flip_h = direction > 0

	# Move RayCast to front side
	#ledge_ray.position.x = abs(ledge_ray.position.x) * direction

func set_trapped():
	state = 0
	
	velocity = Vector2.ZERO
	set_physics_process(false)

	$CollisionShape2D.set_deferred("disabled", true)
	#$CollisionShape2D.disabled = true
	#$CollisionShape2D.queue_free()



func release():
	print(state)
	set_physics_process(true)

	state = 1
	

	$CollisionShape2D.disabled = false




func die():
	emit_signal("enemy_defeated")
	queue_free()
