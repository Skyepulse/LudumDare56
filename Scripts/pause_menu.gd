extends Control
@onready var pauseMenu = $Menu
@onready var blurrFilter = $BlurrFilter
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pauseMenu.hide() # Replace with function body.
	blurrFilter.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game()

func pause_game() -> void :
	if paused :
		pauseMenu.hide()
		blurrFilter.hide()
		Engine.time_scale = 1
	else :
		pauseMenu.show()
		blurrFilter.show()
		Engine.time_scale=0
	paused = !paused

func home_menu() -> void :
	Engine.time_scale = 1
	paused = false
	get_tree().change_scene_to_file("res://Level Scenes/control.tscn")
	
