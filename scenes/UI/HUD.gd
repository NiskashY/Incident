extends CanvasLayer

class_name HUD

@onready var background: TextureRect = $CanvasModulate/BackgroundImage
@onready var focus_layout = $CanvasModulate/VBoxContainer/InventoryLayout/InventoryButton

var inventory_scene = preload("res://scenes/Menu/inventory.tscn")
var inventory = null

var is_focus_exist: bool = false
var is_modulate: bool = false
var is_entered: bool = false


# -------------------------------SIGNALS------------------------

func _ready():
	inventory = inventory_scene.instantiate()
	inventory.connect("inventory_closed", _on_inventory_close_button_pressed)
	$CanvasModulate.set_visible(is_modulate)

func _on_area_2d_mouse_entered():
	is_entered = true

func _on_area_2d_mouse_exited():
	is_entered = false


func _process(_delta):
	if is_entered:
		if Input.is_action_pressed("LMB"):
			menu_button_clicked()

	
	if !is_focus_exist and is_arrow_keys_pressed():
		focus_layout.grab_focus()
		is_focus_exist = true
		print("focused")
		
	if Input.is_action_pressed("ESC"):
		if is_focus_exist:
			focus_layout.grab_focus()
			focus_layout.release_focus()
			is_focus_exist = false
		menu_button_clicked()


# ------------------------------FUNCTIONS------------------------

func is_arrow_keys_pressed() -> bool:
	return Input.is_action_pressed("ui_up") || \
		   Input.is_action_pressed("ui_down")


func find_colision_shape(node, is_disable: bool):
	if node is CollisionShape2D:
		node.disabled = is_disable
		return
	for next_node in node.get_children():
		find_colision_shape(next_node, is_disable)

func menu_button_clicked():
	if $CanvasModulate/Timer.is_stopped():
		is_modulate = !is_modulate		
		
		# TODO: this is needed to fix problem of active area2d
		# 		if we click on them -> they react even if our hud is displayed
		# 		this occuring because the HUD is a CanvasLayer
		find_colision_shape(get_tree().get_root(), is_modulate)
		$Sprite2D/Area2D/CollisionShape2D.disabled = false
		
		$CanvasModulate/Timer.start()
		create_menu_background()


func set_next_animation(fade_out: bool) -> void:
	$Transitions.set_next_animation(fade_out)


func get_background_image_path():
	var scene_top_node: Node = get_node("/root/").get_child(0)
	var path: String = scene_top_node.get_path()
	return path + "/BackgroundImage"


func create_menu_background():
	var current_background: TextureRect = get_node(get_background_image_path())
	assert(current_background != null)
	background.set_texture(current_background.get_texture())
	# Tells that inventory is still open
	if !is_modulate and $CanvasModulate/VBoxContainer.visible == false:
		_on_inventory_close_button_pressed()
	$CanvasModulate.set_visible(is_modulate)

func _on_inventory_button_pressed():
	$CanvasModulate/VBoxContainer.visible = false
	$CanvasModulate.add_child(inventory)

func _on_inventory_close_button_pressed():
	inventory.before_remove()
	$CanvasModulate.remove_child(inventory)
	$CanvasModulate/VBoxContainer.visible = true

func _on_quit_button_pressed():
	get_tree().quit()
