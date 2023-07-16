extends TextureButton

signal day_passed

func _on_pressed():
	emit_signal("day_passed")	
