extends Button

signal button_two_down

var clicked_once = false
@onready var rich_text = $Yes
@onready var not_yet_text = $No
func _ready():
	connect("button_down", Callable(self, "_on_clicked"))
	
func _on_clicked():
	print("single")
	if clicked_once == true:
		if true:#Global.pass_col_one():
			button_two_down.emit()
		#else:
			#not_yet_text.visible = true
			#await get_tree().create_timer(3).timeout
			#not_yet_text.visible = false
			
	else: 
		clicked_once = true
		toggle_double_click_text(clicked_once)
		set_timer()


func set_timer():
	await get_tree().create_timer(1).timeout
	clicked_once = false
	toggle_double_click_text(clicked_once)
	
func toggle_double_click_text(clicked):
	print("double")
	rich_text.visible = clicked
