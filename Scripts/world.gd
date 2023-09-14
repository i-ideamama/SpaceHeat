extends Node2D

@onready var global_variables = get_node("/root/GlobalVariables")

var planet = load("res://Scenes/enemy1.tscn")
var fade = load("res://UI/transitions.tscn")
var prog_vis = true
var time= Time.get_ticks_msec()
var game_is_playing = true

var positions = [
	Vector2(0,1536),
	Vector2(0,-1536),
	Vector2(1536,0),
	Vector2(-1536,0),
	Vector2(1536,1536),
	Vector2(1536,-1536),
	Vector2(-1536,1536),
	Vector2(-1536,-1536)
]

func _ready():
	var t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_in()
	spawn_enemies()

func spawn_enemies():
	positions.shuffle()
	var planet_instance
	for n in 6:
		planet_instance = planet.instantiate()
		add_child(planet_instance)
		planet_instance.position = positions[n]
		planet_instance.colour_number = n+2
		planet_instance.enemy_setup()

func _process(_delta):
	if game_is_playing:
		if global_variables.game_over == false:
			if Input.is_action_just_pressed("show_progress"):
				if prog_vis:
					prog_vis = false
					$CanvasLayer/progression.hide()
				else:
					prog_vis = true
					$CanvasLayer/progression.show()
		elif global_variables.game_over == true:
			
			var t = fade.instantiate()
			$CanvasLayer.add_child(t)
			t.position = Vector2(640,360)
			t.fade_out()
			game_is_playing = false
			$SceneChangeTimer.start()
		global_variables.elapsed_time = snapped((Time.get_ticks_msec() - time)/1000.0, 0.1)
		$CanvasLayer/Label.text = "{s} secs".format({"s": global_variables.elapsed_time})

func _on_scene_change_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
