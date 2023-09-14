extends Control


@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false

func fade_out():
	self.visible = true
	animation_player.play("fade_out")

func fade_in():
	self.visible = true
	animation_player.play("fade_in")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
