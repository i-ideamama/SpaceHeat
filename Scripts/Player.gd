extends CharacterBody2D

@onready var global_variables = get_node("/root/GlobalVariables")

@export var speed = 850
@export var friction = 0.07
@export var acceleration = 0.12


func _ready():
	global_variables.player_colour_number = 1


func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(_delta):
	global_variables.player_position = self.position
	
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()


func _on_colour_swap_area_body_entered(body):
	if "Enemy" in body.name:
		$AudioStreamPlayer2D.play()
		var enem_colour_plus_1 = body.colour_number +1
		var enem_colour_minus_1 = body.colour_number -1
		if ((global_variables.player_colour_number == enem_colour_minus_1) or (global_variables.player_colour_number == enem_colour_plus_1)):
			global_variables.swap_colour(body)
			$Sprite2D.texture = load("res://Assets/planets/{num}.png".format({"num": global_variables.player_colour_number}))
			global_variables.check_game_over()

func arr(body):
	$arrow.rotation=get_angle_to(body.position)
