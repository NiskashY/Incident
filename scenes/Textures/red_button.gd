extends TextureButton


@export var is_sticking_button: bool = false

var normal_image: Texture2D = preload("res://art/button-normal.png")
var bright_image: Texture2D = preload("res://art/button-bright.png")
var is_pressed: bool = false

func _on_pressed():
	if is_sticking_button:
		is_pressed = !is_pressed
		set_texture_normal(bright_image if is_pressed else normal_image)
