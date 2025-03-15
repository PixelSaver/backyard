extends LineEdit

var rng = RandomNumberGenerator.new()
func _ready():
	connect("text_changed", Callable(self, "_text_changed"))
	
func _text_changed(new_text: String) -> void:
	# Get the last character, repeat it once or twice more sometimes 
	# 0 to 1 float
	var rand = randf()
	# 1 to 2 times 
	var randTimes = int((rand * 3)) + 1
	# last characer
	var lastChar = new_text.substr((new_text.length() - 1), 1)
	var addition = lastChar
	
	for i in range(randTimes - 1):
		addition += lastChar
	
	var newFullText = new_text.substr(0, new_text.length() - 1) + addition
	
	if lastChar == "@":
		print("ATTT")
		var char_list : Array = text.split("")  # Convert string to array of characters
		char_list.shuffle() # Shuffle the array
		newFullText =  "".join(char_list)  # Reassemble the string
		
	# Set new text to everything except last character + last character repeated a bit
	text = newFullText
	caret_column = newFullText.length() 
