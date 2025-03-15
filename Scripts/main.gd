extends Node2D

@export_category("Form Stuff")
@export var column_width :int 
@export var column_heights : Array[int]
@export var scroll_speed = 50
@export var scroll_smoothing = 10
@onready var camera = get_viewport().get_camera_2d()

@export var button : Button
var curr_col :int 


func _ready():
	camera.position_smoothing_enabled = true
	
	camera.position_smoothing_speed = scroll_smoothing
	
func _process(delta: float) -> void:
	var button_pos = button.global_position
	var mouse_pos = get_global_mouse_position()
	var distance = (mouse_pos - button_pos).length()
	
	if distance < 100:  # Only push if close enough
		var strength = exp(-pow(distance / 50.0, 2)) * 100  # Gaussian falloff
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
		camera.position.y = clamp(camera.position.y, 0, column_heights[curr_col])
	if event.is_action_pressed("ui_left"):
		traverse_form(-1)
	if event.is_action_pressed("ui_right"):
		traverse_form(1)



func traverse_form(num:int):
	curr_col += num
	curr_col = clamp(curr_col, 0, 3)
	camera.position_smoothing_enabled = false
	camera.position.x = curr_col * column_width
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
	if curr_col == 0:
		count += 1
		PhysicsServer2D.area_set_param(get_world_2d().get_space(), PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2(randi_range(-1,1), randi_range(-1,1)))
		jump(node)
