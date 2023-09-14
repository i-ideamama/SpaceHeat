extends Control

var fade = load("res://UI/transitions.tscn")

func _ready():
	var t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_in()

func _on_scene_change_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/home_screen.tscn")

func _on_back_pressed():
	play_transition_animation()
	$SceneChangeTimer.start()

func play_transition_animation():
	var t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_out()
