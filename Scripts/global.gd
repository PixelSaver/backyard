extends Node2D

var curr_col : int = 0

signal traverse_form 

func pass_col_one() -> bool:
	if $"Lists/1/OptionButton".text != "Backyard Silicon Valley":
		return false
	elif $"Lists/1/EmailInput".text == "":
		return false
	elif $"Lists/1/Control/First".text != "First Name" and $"Lists/1/Control/Last".text != "Last Name":
		return false
	#elif 
	return true
