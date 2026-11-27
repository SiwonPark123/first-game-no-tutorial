extends Node2D

var coins := 0

@onready var num_of_coins: Label = $Labels/NumOfCoins
@onready var fruit_animation: AnimationPlayer = $Fruit/AnimationPlayer

func add_coins():
	coins += 1
	print("coin added")
	num_of_coins.text = "You have collected\n " + str(coins) + "/5 coins"
	if coins == 5:
		fruit_animation.play("fruit_fall")
