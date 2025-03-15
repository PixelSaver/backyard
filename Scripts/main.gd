extends Node2D

@export_category("Cursor")
@export var cursor_sprite : Sprite2D
@export var button : Button
var fake_cursor_pos = Vector2()


func _process(delta: float) -> void:
	var button_pos = UI_to_global(button.global_position)
	if (get_global_mouse_position() - button_pos).length() < 50:
		print("CLOSE")
		warp_mouse_vec(get_global_mouse_position() - button_pos)
	pass
	
func UI_to_global(pos : Vector2) -> Vector2:
	return Vector2(pos.x - 1152/2, pos.y - 648/2)
	

func _input(event):
	if event.is_action("ui_accept"):
		print("moving")
		warp_mouse_vec(Vector2(100,100))

func warp_mouse_vec(direction : Vector2):
	Input.warp_mouse(get_viewport().get_mouse_position() + direction)
