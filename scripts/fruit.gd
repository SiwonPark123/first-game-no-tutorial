extends Area2D

@onready var pickup: AudioStreamPlayer2D = $Pickup
@onready var transition_timer: Timer = $TransitionTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	pickup.play()
	collision_shape.queue_free()
	Engine.time_scale = 0.5
	transition_timer.start()

func _on_transition_timer_timeout() -> void:
	Engine.time_scale = 1
	if get_tree().current_scene.scene_file_path == "res://scenes/level_1.tscn":
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
