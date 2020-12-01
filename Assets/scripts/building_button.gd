extends TextureButton

signal building_selected(build_name)

export var building_name = ""

func _pressed():
		emit_signal("building_selected", building_name)
	
