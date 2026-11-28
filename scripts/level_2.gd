extends Node2D

var coins := 0

@onready var num_of_coins: Label = $NumOfCoins
@onready var fruit_animation: AnimationPlayer = $Fruit/AnimationPlayer

func _ready() -> void:
	CoinSignal.coin_collect.connect(_on_coin_collect)

func _on_coin_collect() -> void:
	coins += 1
	num_of_coins.text = "You have collected\n " + str(coins) + "/5 coins"
	if coins == 5:
		fruit_animation.play("fall")
