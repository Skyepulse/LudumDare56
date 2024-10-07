extends Control
@onready var hints = $Hints
var text = ""

func hover_cars() -> void :
	hints.clear()
	text = "Cars and Trucks will squish your animals!"
	display_text()
	
func hover_road() -> void : 
	hints.clear()
	text = "Get your animals to the other side to score points!"
	display_text()
	
func hover_throwing_zone() -> void : 
	hints.clear()
	text = "Throw your animals from here on the road to get them to cross!"
	display_text()

func hover_pen() -> void : 
	hints.clear()
	text = "Store your animals in the pen, they will reproduce. \n Watch out for predators..."
	display_text()
	
func exit_object() -> void :
	hints.clear()
	text = "Hover objects to know more"
	display_text()

func display_text()->void :
	hints.add_text(text)
	hints.show()

func hide_text() -> void :
	hints.clear()
	hints.hide()
func go_menu() -> void :
	get_tree().change_scene_to_file("res://Level Scenes/control.tscn")

func hover_predator() -> void : 
	hints.clear()
	text = "Predators eat your stack... \n domesticate them by dragging them in the pen!"
	display_text()
