extends Button

func _ready():
	connect("button_down", Callable(self, "reload"))

func reload():
	get_tree().reload_current_scene()
