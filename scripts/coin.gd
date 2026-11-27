extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var pickup: AudioStreamPlayer2D = $Pickup
@onready var timer: Timer = $QueueFreeTimer
@onready var level: Node2D = $"../.."

func _on_body_entered(body: Node2D) -> void:
	pickup.play()
	level.add_coins()
	remove_child(animated_sprite)
	remove_child(collision_shape)
	timer.start()


func _on_queue_free_timer_timeout() -> void:
	queue_free()
