extends Node2D

# @onready var position_camera = get_screen_center_position()
# @onready var size_camera = get_viewport_rect().size() 

#var top_left_position = (position_camera - (0.5*size_camera))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	while (1):
		var rand = randf()
		if rand <= 0.2:
			_on_timer_timeout()
		

func _on_timer_timeout() -> void:
	var voiture: PackedScene = preload("res://PrefabScenes/voiture.tscn")
	var voiture_instance = voiture.instance()
	add_child(voiture_instance)
	voiture_instance.position = Vector2(100, 100)