extends Control

var levelPathsArray = ["res://Level Scenes/Level1.tscn",
						"res://Level Scenes/Level2.tscn",
						"res://Level Scenes/Level3.tscn",
						"res://Level Scenes/Level4.tscn",
						"res://Level Scenes/Level5.tscn"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void :
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func goToLevel(number : int) -> void :
	#temp definition
	get_tree().change_scene_to_file(levelPathsArray[number-1])
	
func go_home() -> void :
	get_tree().change_scene_to_file("res://Level Scenes/control.tscn")
func replay() -> void :
	goToLevel(LevelNumber.level_number)
