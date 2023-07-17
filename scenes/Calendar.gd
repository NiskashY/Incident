extends Node2D

signal end_of_month

@onready var hud: HUD = $"../HUD"
@onready var date_counter_label: Label = $Label
var date_counter: int = 1
const MAX_DATE_COUNTER: int = 31

func _on_bed_go_to_sleep():
	if $Timer.is_stopped():
		date_counter += 1
		if date_counter > MAX_DATE_COUNTER:
			emit_signal("end_of_month")
		date_counter_label.text = str(date_counter)
		hud.set_next_animation(true)
		hud.set_next_animation(false)
		# TODO is it possible to do this better?
		$Timer.start()
	
