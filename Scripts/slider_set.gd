extends Control	

func _ready():
	$Label.text = "+00 (000)-000-0000"

func _on_h_slider_value_changed(value: float) -> void:
	var rounded_value : int = roundf(value) 
	var strVal = str(rounded_value)
	if (strVal.length() < 12):
		#print("length is " + str(strVal.length()))
		for n in (12 - strVal.length()):
			#print("adding a zero")
			strVal = "0" + strVal 
	$Label.text = "+%s (%s)-%s-%s" % [strVal.substr(0, 2), strVal.substr(3, 3), strVal.substr(5, 3), strVal.substr(8, 4)]
