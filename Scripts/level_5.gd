extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelNumber.level_number = 5; # Replace with function body.

func win()-> void : 
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Level Scenes/Credits.tscn")
	
func lose()-> void : 
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Level Scenes/lose_screen.tscn")
