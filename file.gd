extends Node2D

func _ready():
	save("350")
	print(l())


func save(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(content)

func l():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content
