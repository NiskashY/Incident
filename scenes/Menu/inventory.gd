extends Node2D

signal inventory_closed

const slot_scene = preload("res://scenes/Menu/Slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null
var holding_item_previous_slot = null



func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))

func _input(_event: InputEvent):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func _on_close_button_pressed():
	put_holding_into_empty_slot(holding_item_previous_slot)
	emit_signal("inventory_closed")


func slot_gui_input(event: InputEvent, slot: slot_scene):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			assert(holding_item != null)
			# item already picked by event.pressed before and
			# placed into holding item object
			$ItemImage.set_texture(holding_item.get_texture())
			
			# this is needed to put currently taken item (by one click) from slot
			put_holding_into_empty_slot(holding_item_previous_slot)
		elif event.pressed:
			move_item(event, slot)			

func move_item(event: InputEventMouseButton, slot: slot_scene):
	if holding_item != null:
		if !slot.item:	# Place holding item into the slot
			put_holding_into_empty_slot(slot)
		else: 			# Swap item slot and holding item
			var slot_item = slot.pickFromSlot()
			slot_item.global_position = event.global_position
			slot.putIntoSlot(holding_item)
			holding_item = slot_item
			holding_item_previous_slot = slot			
	elif slot.item:
		holding_item = slot.pickFromSlot()
		holding_item.global_position = get_global_mouse_position()
		holding_item_previous_slot = slot		

func put_holding_into_empty_slot(slot: slot_scene):
	if holding_item:
		slot.putIntoSlot(holding_item)
		holding_item = null
	
func before_remove():
	put_holding_into_empty_slot(holding_item_previous_slot)
