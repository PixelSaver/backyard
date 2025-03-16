extends Button

func _ready():
	connect("button_down", Callable(self, "quit"))

func quit():
	get_tree().quit()
