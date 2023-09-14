extends Node

var player_colour_number
var player_position
var game_over = false
var elapsed_time 

func swap_colour(enemy):
	if "Enemy" in enemy.name:
		var temp = player_colour_number
		player_colour_number = enemy.colour_number
		enemy.swap_colour(temp)

func check_game_over():
	if player_colour_number == 7:
		game_over = true
