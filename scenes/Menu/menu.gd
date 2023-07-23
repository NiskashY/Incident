extends Control

var is_focus_exist: bool = false

func _ready():
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_options_button_pressed():
	var options_scene = load("res://scenes/Menu/options.tscn").instantiate()
	get_tree().current_scene.add_child(options_scene)
	

func _on_quit_button_pressed():
	get_tree().quit()


func _process(_delta):
	if !is_focus_exist && (Input.is_action_pressed("ui_up") || \
	   Input.is_action_pressed("ui_down")):
		$VBoxContainer/StartLayout/StartButton.grab_focus()
		is_focus_exist = true
	elif is_focus_exist && Input.is_action_pressed("ESC"):
		$VBoxContainer/StartLayout/StartButton.grab_focus()
		$VBoxContainer/StartLayout/StartButton.release_focus()		
		is_focus_exist = false
	elif Input.is_action_pressed("one_key"):
		_on_start_button_pressed()
	elif Input.is_action_pressed("two_key"):
		_on_options_button_pressed()
	elif Input.is_action_pressed("three_key"):
		_on_quit_button_pressed()
		
	
