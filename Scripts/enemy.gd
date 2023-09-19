extends CharacterBody2D

@onready var global_variables = get_node("/root/GlobalVariables")

var colour_number
var state
var direction = Vector2.ZERO
var states = ["MOVE","STOP"]
var player_in_vicinity = false
var run_away_from_player = null

var ray_cast_length = 138

var player_colour_number_plus1
var player_colour_number_minus1

@export var speed = 700
@export var friction = 0.07
@export var acceleration = 0.08

func _ready():
	player_colour_number_plus1 = global_variables.player_colour_number+1
	player_colour_number_minus1 = global_variables.player_colour_number-1

func enemy_setup():
	$Sprite2D.texture = load("res://Assets/planets/{num}.png".format({"num": colour_number}))
	
	state = get_random_state()
	direction = get_random_direction()
	$StateTimer.start()

func _physics_process(_delta):
	player_colour_number_plus1 = global_variables.player_colour_number+1
	if (player_colour_number_plus1 == colour_number):
		get_parent().get_node("Player/arrow").visible=true
		get_parent().get_node("Player").arr(self)	
	
	
	if state ==  "MOVE":
		if player_in_vicinity == true:
			if run_away_from_player == true:
				move_away_from_player()
			elif run_away_from_player == false:
				move_towards_player()
			else:
				pass
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	elif state == "STOP":
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if "Wall" in collision.get_collider().name:
				direction*=-1
			if "Enemy" in collision.get_collider().name:
				direction*=-1
			if "Player" in collision.get_collider().name:
				$PlayerFollowTimer.start()
	

func do_collisions_and_stuff():
	var vel = Vector2(speed, direction)
	var collision = move_and_collide(vel)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()


func get_random_state():
	var random_state = states[randi() % states.size()]
	return random_state

func get_random_direction():
	var rand_x_direction = randf_range(-1, 1)
	var rand_y_direction = randf_range(-1, 1)
	if rand_x_direction == 0.0 and rand_y_direction == 0.0:
		return Vector2(1,1)
	else:
		return Vector2(rand_x_direction,rand_y_direction)
	
func _on_state_timer_timeout():
	if player_in_vicinity == false:
		state = get_random_state()
		direction = get_random_direction()
		$StateTimer.start()
	elif player_in_vicinity == true:
		pass



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		state = "MOVE"
		player_in_vicinity = true
		player_colour_number_plus1 = global_variables.player_colour_number+1
		player_colour_number_minus1 = global_variables.player_colour_number-1
		if (player_colour_number_plus1 == colour_number):
			move_away_from_player()
			run_away_from_player = true
			$StateTimer.stop()
		elif (player_colour_number_minus1 == colour_number):
			move_towards_player()
			$PlayerFollowTimer.start()
			run_away_from_player = false
			$StateTimer.stop()
		else:
			run_away_from_player = null
		
func move_away_from_player():
	direction = position - global_variables.player_position
	
func move_towards_player():
	direction = self.position.direction_to(global_variables.player_position)
	
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_vicinity = false
		$StateTimer.start()

func swap_colour(c_num):
	colour_number = c_num
	$Sprite2D.texture = load("res://Assets/planets/{num}.png".format({"num": c_num}))
	if run_away_from_player:
		run_away_from_player = false
	elif run_away_from_player == false:
		run_away_from_player = true
		
func _on_player_follow_timer_timeout():
	run_away_from_player = null
	direction*=-1
	$StateTimer.start()



