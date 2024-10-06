extends Node2D

class_name PredatorSpawner

# Singleton Instance
static var instance: PredatorSpawner = null

# Exported Variables

# Load scenes
var predator_scenes = {
	Animal.AnimalType.BETTER_SLUG: preload("res://PrefabScenes/Predators/predator_better_slug.tscn"),
	Animal.AnimalType.TOAD: preload("res://PrefabScenes/Predators/predator_toad.tscn"),
	Animal.AnimalType.SNAKE: preload("res://PrefabScenes/Predators/predator_snake.tscn"),
	Animal.AnimalType.CHICKEN: preload("res://PrefabScenes/Predators/predator_chicken.tscn"),
	Animal.AnimalType.FOX: preload("res://PrefabScenes/Predators/predator_fox.tscn"),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Singleton
	if instance == null:
		instance = self
	else:
		queue_free()
		return


func spawn_predator(type: Animal.AnimalType, at: Vector2) -> void:
	var predator = predator_scenes[type].instance()
	predator.position = at
	get_parent().add_child(predator)
