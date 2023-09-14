extends StaticBody2D

var bush_num

# Called when the node enters the scene tree for the first time.
func _ready():
	bush_num = (randi() % 4) + 1
	$Sprite2D.texture = load("res://Assets/Bushes/{num}.png".format({"num": bush_num}))
