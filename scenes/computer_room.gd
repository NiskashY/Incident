extends Node2D

var is_in_exit_area: bool = false
var is_in_monitor_area: bool = false


# -------------------------SIGNALS------------------------------

func _ready():
	$HUD.visible = true

func _on_exit_area_mouse_entered():
	is_in_exit_area = true

func _on_monitor_area_mouse_entered():
	is_in_monitor_area = true

func _on_exit_area_mouse_exited():
	is_in_exit_area = false
	
func _on_monitor_area_mouse_exited():
	is_in_monitor_area = false

	
func _process(_delta):
	if Input.is_action_pressed("LMB"):
		if is_in_exit_area:
			get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
		elif is_in_monitor_area:
			get_tree().change_scene_to_file("res://scenes/test_scene.tscn")			
		

