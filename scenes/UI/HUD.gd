extends CanvasLayer

class_name HUD

@onready var focus_layout = $CanvasModulate/VBoxContainer/SomethingLayout/RedButton
var is_focus_exist: bool = false
var is_modulate: bool = false
var is_entered: bool = false

func _ready():
	$CanvasModulate.set_visible(is_modulate)

func _on_area_2d_mouse_entered():
	is_entered = true

func _on_area_2d_mouse_exited():
	is_entered = false


func _process(_delta):
	if is_entered:
		if Input.is_action_pressed("LMB") and \
		   $CanvasModulate/Timer.is_stopped():
			is_modulate = !is_modulate
			
			$CanvasModulate/Timer.start()
			$CanvasModulate.set_visible(is_modulate)
	
	if !is_focus_exist && (Input.is_action_pressed("ui_up") || \
	   Input.is_action_pressed("ui_down")):
		focus_layout.grab_focus()
		is_focus_exist = true
		print("focused")
	elif is_focus_exist && Input.is_action_pressed("ESC"):
		focus_layout.grab_focus()
		focus_layout.release_focus()		
		is_focus_exist = false
		

func set_next_animation(fade_out: bool) -> void:
	$Transitions.set_next_animation(fade_out)
