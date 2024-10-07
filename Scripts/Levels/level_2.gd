extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelNumber.level_number = 2; # Replace with level number.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func win()-> void : 
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Level Scenes/win_screen.tscn")
	
func lose()-> void : 
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Level Scenes/lose_screen.tscn")
