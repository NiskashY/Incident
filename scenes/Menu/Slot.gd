extends Panel

var default_texture: Texture2D # preload("")
var empty_texture: Texture2D # preload("")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var item_scene = preload("res://scenes/Attributes/item.tscn")
var item = null

func _ready():
	default_style = StyleBoxTexture.new()
	default_style.texture = default_texture
	
	empty_style = StyleBoxTexture.new()
	empty_style.texture = empty_texture
	
	
	if randi() % 2:
		item = item_scene.instantiate()
		add_child(item)
	refresh_style()
	
	
func refresh_style():
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set("custom_styles/panel", default_style)
		

func pickFromSlot():
	var ret = item
	remove_child(item)
	var inventory_node = find_parent("Inventory")
	inventory_node.add_child(item)
	item = null
	refresh_style()
	return ret
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2.ZERO
	var inventory_node = find_parent("Inventory")
	inventory_node.remove_child(item)
	add_child(item)
	refresh_style()
















