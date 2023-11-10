extends Node

signal gained_coins(int)

var coins = 0

var current_checkpoint : Checkpoint

var player : Player

func reswan_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins",coins_gained)
	print(coins)
