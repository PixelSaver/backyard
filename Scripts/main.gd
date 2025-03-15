extends Node2D

@export_category("Cursor")
@export var cursor_sprite : Sprite2D
@export var button : Button
@export_category("Form Stuff")
@export var column_width :int 
@export var column_heights : Array[int]
@export var scroll_speed = 50
@export var scroll_smoothing = 10
@onready var camera = get_viewport().get_camera_2d()

var curr_col :int 


func _ready():
	camera.position_smoothing_enabled = true
	
	camera.position_smoothing_speed = scroll_smoothing
	
func _process(delta: float) -> void:
	if (get_global_mouse_position() - button.position).length() < 50:
		print("CLOSE")
		warp_mouse_vec(get_global_mouse_position() - button.position)
	

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
	camera.position_smoothing_enabled = true
	

func warp_mouse_vec(direction : Vector2):
	Input.warp_mouse(get_viewport().get_mouse_position() + direction)
