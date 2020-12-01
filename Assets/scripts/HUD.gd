extends CanvasLayer

signal build_start(building_name)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_building_selected(build_name):
	get_node("HBoxContainer/residential_menu").visible = false
	get_node("HBoxContainer/residential_menu").button_pressed = false	
	get_node("HBoxContainer/commercial_menu").visible = false
	get_node("HBoxContainer/commercial_menu").button_pressed = false	
	get_node("HBoxContainer/research_menu").visible = false
	get_node("HBoxContainer/research_menu").button_pressed = false	
	get_node("HBoxContainer/industrial_menu").visible = false
	get_node("HBoxContainer/industrial_menu").button_pressed = false	
	get_node("HBoxContainer/residential_menu/BuildingContainer").visible = false
	get_node("HBoxContainer/commercial_menu/BuildingContainer").visible = false
	get_node("HBoxContainer/research_menu/BuildingContainer").visible = false
	get_node("HBoxContainer/industrial_menu/BuildingContainer").visible = false
	$HBoxContainer/build_menu.pressed = false  # Replace with function body.
	emit_signal("build_start", build_name)

