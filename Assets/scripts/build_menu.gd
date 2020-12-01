extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _toggled(button_pressed):
	if(button_pressed):
		get_parent().get_node("residential_menu").visible = true

		get_parent().get_node("commercial_menu").visible = true
		get_parent().get_node("research_menu").visible = true
		get_parent().get_node("industrial_menu").visible = true
		get_parent().get_node("residential_menu/BuildingContainer").visible = false
		get_parent().get_node("commercial_menu/BuildingContainer").visible = false
		get_parent().get_node("research_menu/BuildingContainer").visible = false
		get_parent().get_node("industrial_menu/BuildingContainer").visible = false
	else:
		get_parent().get_node("residential_menu").visible = false
		get_parent().get_node("residential_menu").button_pressed = false
		get_parent().get_node("commercial_menu").visible = false
		get_parent().get_node("commercial_menu").button_pressed = false
		get_parent().get_node("research_menu").visible = false
		get_parent().get_node("research_menu").button_pressed = false
		get_parent().get_node("industrial_menu").visible = false
		get_parent().get_node("industrial_menu").button_pressed = false		
		get_parent().get_node("residential_menu/BuildingContainer").visible = false
		get_parent().get_node("commercial_menu/BuildingContainer").visible = false
		get_parent().get_node("research_menu/BuildingContainer").visible = false
		get_parent().get_node("industrial_menu/BuildingContainer").visible = false
		
		
