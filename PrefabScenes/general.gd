extends Node2D

var voiture: PackedScene = preload("res://PrefabScenes/Voiture.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		var rand = randf()
		if rand <= 0.2:
			_on_timer_timeout()
		

func _on_timer_timeout() -> void:
	var voiture_instance = voiture.instance()
	add_child(voiture_instance)
	voiture_instance.position = Vector2(100, 100)