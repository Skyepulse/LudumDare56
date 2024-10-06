extends Node2D

class_name PredatorSpawner

# Singleton Instance
static var instance: PredatorSpawner = null

# Exported Variables
@export var vivier: Vivier = null
@export var spawn_interval: float = 5

# Load scenes
var predator_scenes = {
	Animal.AnimalType.BETTER_SLUG: preload("res://PrefabScenes/Predators/predator_better_slug.tscn"),
	Animal.AnimalType.TOAD: preload("res://PrefabScenes/Predators/predator_toad.tscn"),
	Animal.AnimalType.SNAKE: preload("res://PrefabScenes/Predators/predator_snake.tscn"),
	Animal.AnimalType.CHICKEN: preload("res://PrefabScenes/Predators/predator_chicken.tscn"),
	Animal.AnimalType.FOX: preload("res://PrefabScenes/Predators/predator_fox.tscn"),
}

func _ready():
	# Singleton
	if instance == null:
		instance = self
	else:
		queue_free()
		return

func spawn_predator(type: PackedScene, at: Vector2) -> void:
	var predator: Predator = type.instantiate()
	predator.position = at
	predator.target_stack = vivier
	get_parent().add_child(predator)


func _on_timer_timeout():
	var at = Vector2(randf_range(0, 1920), randf_range(0, 1080))
	var type = (1 + randi() % (Animal.AnimalType.ALIEN - 1))
	spawn_predator(predator_scenes[type], at)
