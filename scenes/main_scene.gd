extends Node2D

var is_mouse_in_change_scene_area: bool = false

# --------------------MAIN FUNCTIONS----------------
func _process(_delta):
	if is_mouse_in_change_scene_area:
		if Input.is_action_pressed("LMB"):
			get_tree().quit()

# --------------------SIGNALS------------------------
func _on_area_change_scene_mouse_entered():
	is_mouse_in_change_scene_area = true


func _on_area_change_scene_mouse_exited():
	is_mouse_in_change_scene_area = false


func _on_calendar_end_of_month():
	get_tree().quit()
