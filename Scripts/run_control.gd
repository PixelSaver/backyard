extends Control

var runAway = true

var rng = RandomNumberGenerator.new()

# Distance within which the button should move towards the cursor
var proximity_distance = 100.0

# Speed at which the button moves when the cursor is near
var move_speed = 15.0

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_mouse_entered() -> void:
	#runAway = true
	pass

func _on_button_run_pressed() -> void:
	runAway = false
	print("stop")

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()

	# Check if the cursor is within the bounds of the Control node
	if get_rect().has_point(mouse_position):
		var randX = rng.randf_range(-2, 2)
		var randY = rng.randf_range(-2, 2)
		
		var screenSize = DisplayServer.screen_get_size()
		
		
		$ButtonRun.position += Vector2(randX * 20, randY * 20)
		$".".position += Vector2(randX * 20, randY * 20)
		#$ButtonRun.position -= direction * move_speed * delta
		#$".".position -= direction * move_speed * delta

		
