extends Control
@onready var pauseMenu = $"."
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pauseMenu.hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game() -> void :
	if paused :
		pauseMenu.hide()
		Engine.time_scale = 1
	else :
		pauseMenu.show()
		Engine.time_scale=0
	paused = !paused

func home_menu() -> void :
	get_tree().change_scene_to_file("res://Level Scenes/control.tscn")
	
