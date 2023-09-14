extends Control

var fade = load("res://UI/transitions.tscn")
var scene_to_change_to
var t

func _ready():
	t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_in()

func _on_iamlost_pressed():
	play_transition_animation()
	scene_to_change_to = "res://Scenes/i_am_lost.tscn"
	$SceneChangeTimer.start()

func _on_controls_pressed():
	play_transition_animation()
	scene_to_change_to = "res://Scenes/controls.tscn"
	$SceneChangeTimer.start()

func _on_credits_pressed():
	play_transition_animation()
	scene_to_change_to = "res://Scenes/credits.tscn"
	$SceneChangeTimer.start()

func _on_play_pressed():
	play_transition_animation()
	scene_to_change_to = "res://Scenes/world.tscn"
	$SceneChangeTimer.start()

func play_transition_animation():
	t = fade.instantiate()
	$CanvasLayer.add_child(t)
	t.position = Vector2(640,360)
	t.fade_out()

func _on_scene_change_timer_timeout():
	get_tree().change_scene_to_file(scene_to_change_to)


func _on_timer_timeout():
	pass
