extends Node2D

var voiture: PackedScene = preload("res://PrefabScenes/Voiture.tscn")
var road: PackedScene = preload("res://PrefabScenes/sprite_2d.tscn")

var delay = 0.15 #Time between car
var time_passed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var route = road.instantiate()
	add_child(route)
	var camera = $Camera2D
	route.position = camera.top_left_position + Vector2(route.texture.get_width(),route.texture.get_height())/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta  # Incrémente le temps écoulé
	var rand = randf()
	if time_passed >= delay:
		if rand <= 0.4: #probability that there is a car on delay
			_on_timer_timeout()
		time_passed = 0.0    
		

func _on_timer_timeout() -> void:
	var voiture_instance = voiture.instantiate()
	add_child(voiture_instance)

	var camera = $Camera2D
	voiture_instance.position = camera.top_left_position + Vector2(0,102)
	voiture_instance._process(1)
