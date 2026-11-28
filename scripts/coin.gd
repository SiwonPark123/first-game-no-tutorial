extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var pickup: AudioStreamPlayer2D = $Pickup
@onready var timer: Timer = $QueueFreeTimer

func _on_body_entered(body: Node2D) -> void:
	pickup.play()
	CoinSignal.coin_collect.emit()
	remove_child(animated_sprite)
	remove_child(collision_shape)
	timer.start()


func _on_queue_free_timer_timeout() -> void:
	queue_free()
