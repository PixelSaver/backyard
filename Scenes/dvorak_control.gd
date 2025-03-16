extends Control

var qwertyToDvorak = {
	"a": "a", "b": "x", "c": "j", "d": "f", "e": "u", "f": "p", "g": "g", "h": "l", "i": "y", "j": "f",
	"k": "p", "l": "r", "m": "l", "n": "s", "o": "t", "p": "d", "q": "'", "r": "n", "s": "o", "t": "e",
	"u": "i", "v": "c", "w": ",", "x": "v", "y": "k", "z": "b",

	"A": "A", "B": "X", "C": "J", "D": "F", "E": "U", "F": "P", "G": "G", "H": "L", "I": "Y", "J": "F",
	"K": "P", "L": "R", "M": "L", "N": "S", "O": "T", "P": "D", "Q": "'", "R": "N", "S": "O", "T": "E",
	"U": "I", "V": "C", "W": ",", "X": "V", "Y": "K", "Z": "B",

	"1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6", "7": "7", "8": "8", "9": "9", "0": "0",
	"-": "[", "=": "]", 
	"[": "]", "]": "[",
	";": ";", "'": ",", 
	",": "p", ".": "w", "/": "v",
	
	"`": "`", 
	"~": "~",
	"\\": "\\", "|": "\\",
}

func _on_dvorak_line_edit_text_changed(new_text: String) -> void:
	print("seen")
	# Get the last character, repeat it once or twice more sometimes 
	# 0 to 1 float
	var rand = randf()
	# 1 to 2 times 
	var randCharInt = int((rand * 3)) + 1
	# last characer
	var lastChar = new_text.substr((new_text.length() - 1), 1)
	var convertedChar = "" 
	if (qwertyToDvorak.has(lastChar)): 
		convertedChar = qwertyToDvorak[lastChar]
	
	var newFullText = new_text.substr(0, new_text.length() - 1) + convertedChar
	
	# Set new text to everything except last character + last character repeated a bit
	$"TextureRect/Dvorak Line Edit".text = newFullText
	$"TextureRect/Dvorak Line Edit".caret_column = newFullText.length() 
