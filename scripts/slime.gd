extends Node2D

const SPEED = 60
var direction = 1
@onready var right_ray: RayCast2D = $RightRayCast
@onready var left_ray: RayCast2D = $LeftRayCast
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * delta * 60
	if right_ray.is_colliding():
		animated_sprite.flip_h = true
		direction = -1
	elif left_ray.is_colliding():
		animated_sprite.flip_h = false
		direction = 1
