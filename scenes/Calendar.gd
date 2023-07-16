extends Node2D

signal end_of_month

@onready var date_counter_label: Label = $Label
var date_counter: int = 1
const MAX_DATE_COUNTER: int = 31

func _on_bed_day_passed():
	date_counter += 1
	if date_counter > MAX_DATE_COUNTER:
		emit_signal("end_of_month")
	date_counter_label.text = str(date_counter)
	$"../CanvasLayer/Transitions".set_next_animation(true)
	$"../CanvasLayer/Transitions".set_next_animation(false)
