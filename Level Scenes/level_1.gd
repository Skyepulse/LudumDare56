extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelNumber.level_number = 1; # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win()-> void : 
	get_tree().change_scene_to_file("res://Level Scenes/win_screen.tscn")
