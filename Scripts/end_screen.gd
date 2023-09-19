extends Control

@onready var global_variables = get_node("/root/GlobalVariables")
var fade = load("res://UI/transitions.tscn")

func _ready():
	var t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_in()
	
	
	$CanvasLayer/time.text = "{s} secs".format({"s": global_variables.elapsed_time})
	if(global_variables.elapsed_time<int(l())): 
		$"CanvasLayer/high score".text = "new record"
	else: 
		$"CanvasLayer/high score".text = "high score: {s}".format({"s": l()})


func _on_screen_change_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/home_screen.tscn")


func _on_back_pressed():
	play_transition_animation()
	$ScreenChangeTimer.start()


func _on_quit_pressed():
	get_tree().quit()

func play_transition_animation():
	var t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_out()

func save(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_string(content)

func l():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_as_text()
	return content
