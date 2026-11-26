extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var dying = false
@onready var restart_timer: Timer = $"../RestartTimer"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if !dying:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var direction := Input.get_axis("move_left", "move_right")
		if is_on_floor():
			if direction < 0:
				animated_sprite.play("run")
				animated_sprite.flip_h = true
			elif direction > 0:
				animated_sprite.play("run")
				animated_sprite.flip_h = false
			else:
				animated_sprite.play("idle")
		else:
			animated_sprite.play("jump")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_world_boundary_body_entered(body: Node2D) -> void:
	die()


func _on_restart_timer_timeout() -> void:
	dying = false
	get_tree().reload_current_scene()
	Engine.time_scale = 1


func _on_slime_killzone_body_entered(body: Node2D) -> void:
	die()
	
func die():
	if !dying:
		print("dead")
		dying = true
		animated_sprite.play("death")
		Engine.time_scale = 0.5
		restart_timer.start()
