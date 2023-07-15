extends TextureButton


var normal_image: Texture2D = preload("res://art/button-normal.png")
var bright_image: Texture2D = preload("res://art/button-bright.png")
var is_pressed: bool = false

func _on_pressed():
	is_pressed = !is_pressed
	set_texture_normal(bright_image if is_pressed else normal_image)
