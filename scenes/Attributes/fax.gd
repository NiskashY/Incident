extends Node2D

var is_mouse_in_area: bool = false
var is_fax_printing: bool = false
var is_fax_has_paper: bool = false

func _ready():
	$AnimatedSprite2D.play("idle")


func _on_area_2d_mouse_entered():
	if !is_fax_printing && !is_fax_has_paper:
		$AnimatedSprite2D.play("hover")
	is_mouse_in_area = true
	

func _on_area_2d_mouse_exited():
	if !is_fax_printing && !is_fax_has_paper:
		$AnimatedSprite2D.play("idle")
	is_mouse_in_area = false


func print_documents():
	$AnimatedSprite2D.play("printing")
	is_fax_printing = true
	$AnimatedSprite2D.connect("animation_finished", _on_fax_printing_animation_end)	


func _process(_delta):
	if is_mouse_in_area && !is_fax_printing:
		if Input.is_action_pressed("LMB"):
			if is_fax_has_paper:
				is_fax_has_paper = false
				_on_area_2d_mouse_exited()
			else:
				print_documents()
				print("printing")


func _on_fax_printing_animation_end():
	is_fax_printing = false
	is_fax_has_paper = true
	$AnimatedSprite2D.disconnect("animation_finished", _on_fax_printing_animation_end)
	if !is_mouse_in_area:
		_on_area_2d_mouse_exited()
