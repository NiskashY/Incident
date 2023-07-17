extends TextureButton

signal go_to_sleep

func _on_pressed():
	emit_signal("go_to_sleep")	
