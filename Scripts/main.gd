extends Node2D

@export_category("Form Stuff")
@export var column_width :int 
@export var column_heights : Array[int]
@export var scroll_speed = 50
@export var scroll_smoothing = 10
@export var button2_repel_strength_modifier : float = 1
@onready var camera = get_viewport().get_camera_2d()

@export var button : Button


func _ready():
	camera.position_smoothing_enabled = true
	$"Lists/1/CenterContainer5/Next".connect("button_two_down", Callable(self, "_on_button_2_down"))
	camera.position_smoothing_speed = scroll_smoothing
	
func _process(delta: float) -> void:
	var button_pos = button.global_position
	var button_size = button.size  # Get button dimensions
	
	var mouse_pos = get_global_mouse_position()
	
	var closest_x = clamp(mouse_pos.x, button_pos.x, button_pos.x + button_size.x)
	var closest_y = clamp(mouse_pos.y, button_pos.y, button_pos.y + button_size.y)
	
	var distance = (mouse_pos - Vector2(closest_x, closest_y)).length()
	
	if distance < 100:  # Only push if close enough
		var strength = exp(-pow(distance / 50.0, 2)) * 10 * button2_repel_strength_modifier  # Gaussian falloff
		var push_direction = (mouse_pos - button_pos).normalized()
		warp_mouse_vec(push_direction * strength)
	pass

func _input(event):
	if event.is_action("ui_accept"):
		warp_mouse_vec(Vector2(100,100))
	if event is InputEventMouseButton:
		if event.is_action("mouse_wheel_up"): 
			camera.position.y -= scroll_speed 
		elif event.is_action("mouse_wheel_down"):  
			camera.position.y += scroll_speed  
		camera.position.y = clamp(camera.position.y, 0, column_heights[Global.curr_col])
	if event.is_action_pressed("ui_left"):
		traverse_form(-1)
	if event.is_action_pressed("ui_right"):
		traverse_form(1)



func traverse_form(num:int):
	Global.curr_col += num
	Global.curr_col = clamp(Global.curr_col, 0, 3)
	camera.position_smoothing_enabled = false
	camera.position.x = Global.curr_col * column_width
	camera.position.y = 0
	await get_tree().create_timer(0.0001).timeout
	camera.position_smoothing_enabled = true
	

func warp_mouse_vec(direction : Vector2):
	Input.warp_mouse(get_viewport().get_mouse_position() + direction)

var physics = false
func _on_button_button_down() -> void:
	if physics == false:
		physics = true
		for node in get_tree().get_nodes_in_group("startScreen"):
			node.gravity_scale = 1
			jump(node)
	else:
		traverse_form(1)



var count = 10
func jump(node : RigidBody2D):
	node.linear_velocity = Vector2(randf(),randf()).normalized() *10 * log(count)
	node.angular_velocity = randf_range(-1,1) * 5 * log(count)
	await get_tree().create_timer(1.5).timeout
	if Global.curr_col == 0:
		count += 1
		PhysicsServer2D.area_set_param(get_world_2d().get_space(), PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(randi_range(-1,1), randi_range(-1,1)))
		jump(node)


func _on_button_2_down() -> void:
	print("going")
	traverse_form(1)
