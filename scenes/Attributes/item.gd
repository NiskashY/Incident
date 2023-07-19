extends Node2D

@onready var empty_texture: Texture2D = load("res://art/EMPTY_TEXTURE.png")

func get_texture():
	var return_texture = $TextureRect.get_texture()
	if return_texture == null:
		return_texture = empty_texture
	return return_texture
