extends TextureButton

signal category_activated(cat_name)

export var category_name = ""
var button_pressed = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed():
	button_pressed = !button_pressed
	if(button_pressed):
		$BuildingContainer.visible = true
		emit_signal("category_activated", category_name)
	else:
		$BuildingContainer.visible = false

func on_category_activated(cat_name):
	#if the category isn't this one, disable this one. 
	if(cat_name != category_name):
		$BuildingContainer.visible = false
		button_pressed = false
