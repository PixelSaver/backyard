extends Button


func _on_center_container_6_mouse_entered() -> void:
	#tween.tween_property(self, "rect_scale", 0.1, 2)
	var tween = $".".create_tween() 
	tween.tween_property($".", "scale", Vector2(1.0, 1.0), 100)
	#tween.tween_callback($".".queue_free)


func _on_center_container_6_mouse_exited() -> void:
	#tween.tween_property(self, "rect_scale", 0.1, 2)
	print("entered")
	var tween = $".".create_tween() 
	tween.tween_property($".", "scale", Vector2(0.1, 0.1), 0.3)
	#tween.tween_callback($".".queue_free)
