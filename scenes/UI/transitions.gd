extends Control

class_name Transitioner

func _ready():
	$TextureRect.visible = false

func set_next_animation(fading_out: bool):
	if fading_out:
		$AnimationPlayer.queue("fade_out")
	else:
		$AnimationPlayer.queue("fade_in")
