extends Node2D


const slot_scene = preload("res://scenes/Menu/Slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))
		
func slot_gui_input(event: InputEvent, slot: slot_scene):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:	# Place holding item into the slot
					slot.putIntoSlot(holding_item)
					holding_item = null
				else: 			# Swap item slot and holding item
					var slot_item = slot.pickFromSlot()
					slot_item.gloabal_position = event.global_position
					slot.putIntoSlot(holding_item)
					holding_item = slot_item
			elif slot.item:
				holding_item = slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()

func _input(event: InputEvent):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
