extends CharacterBody2D


var SPEED = 150.0
var JUMP_VELOCITY = -250.0
var dying = false
var god_mode = false
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var restart_timer: Timer = %RestartTimer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_just_pressed("god_mode"):
		god_mode = !god_mode
		if god_mode:
			SPEED = 300
			JUMP_VELOCITY = -400
		else:
			SPEED = 150
			JUMP_VELOCITY = -250
		
		
	
	if Input.is_action_just_pressed("restart"):
		Engine.time_scale = 1
		get_tree().reload_current_scene()
	
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
	else:
		velocity.x = 0

	move_and_slide()

func _on_restart_timer_timeout() -> void:
	dying = false
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	
func die():
	if !dying && !god_mode:
		dying = true
		animated_sprite.play("death")
		restart_timer.start()
		Engine.time_scale = 0.5
