extends Node2D

class_name PredatorSpawner

# Singleton Instance
static var instance: PredatorSpawner = null

# Exported Variables

# Load scenes
# var predator_scene = preload("res://PrefabScenes/predator.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Singleton
	if instance == null:
		instance = self
	else:
		queue_free()
		return


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
