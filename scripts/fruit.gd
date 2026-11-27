extends Area2D

@onready var pickup: AudioStreamPlayer2D = $Pickup
@onready var buffer_to_win: Timer = $BufferToWin

func _on_body_entered(body: Node2D) -> void:
	pickup.play()
	Engine.time_scale = 0.5
	buffer_to_win.start()




func _on_bufferto_win_timeout() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
