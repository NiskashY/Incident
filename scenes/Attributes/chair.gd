extends TextureButton

var is_shifted: bool = false
var angle: float = -PI / 4 

func move():
	is_shifted = !is_shifted
	var angle_to_shift = angle
	if is_shifted:
		angle_to_shift = angle + PI
	position = position + Vector2(1, 0).rotated(angle_to_shift) * 100


func _on_pressed():
	move()
