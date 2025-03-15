extends RigidBody2D

var is_dragging = false
var mouse_over = false
var offset = Vector2()

func _ready():
	$Area2D.mouse_entered.connect(_on_mouse_entered)
	$Area2D.mouse_exited.connect(_on_mouse_exited)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action("left_click"):
			if event.pressed:
				# When the mouse button is pressed, check if the mouse is over the RigidBody2D
				if mouse_over:
					is_dragging = true
					offset = get_global_mouse_position() - global_position
					# Disable physics by setting mode to Kinematic (prevents physics interactions while dragging)
					#mode = RigidBody2D.Mode.Kinematic
			else:
				# When the mouse button is released, stop dragging
				is_dragging = false
				# Re-enable physics by setting the mode back to RigidBody2D
				#mode = RigidBody2D.Mode.Rigid

	if is_dragging:
		# Update position based on mouse movement
		global_position = get_global_mouse_position() - offset


func _on_mouse_exited():
	print("out")
	mouse_over = false
func _on_mouse_entered():
	print("IN")
	mouse_over = true
