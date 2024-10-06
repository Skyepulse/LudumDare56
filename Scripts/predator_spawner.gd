extends Node2D

class_name PredatorSpawner

# Singleton Instance
static var instance: PredatorSpawner = null

# Exported Variables
@export var vivier: Vivier = null

# Get area2D child
@onready var area2D: Area2D = $Area2D

# Load scenes
var predator_scenes = {
	Animal.AnimalType.BETTER_SLUG: preload("res://PrefabScenes/Predators/predator_better_slug.tscn"),
	Animal.AnimalType.TOAD: preload("res://PrefabScenes/Predators/predator_toad.tscn"),
	Animal.AnimalType.SNAKE: preload("res://PrefabScenes/Predators/predator_snake.tscn"),
	Animal.AnimalType.CHICKEN: preload("res://PrefabScenes/Predators/predator_chicken.tscn"),
	Animal.AnimalType.FOX: preload("res://PrefabScenes/Predators/predator_fox.tscn"),
}

var max_animal_level = [Animal.AnimalType.SLUG,Animal.AnimalType.BETTER_SLUG,
						Animal.AnimalType.SNAKE, Animal.AnimalType.CHICKEN,
						Animal.AnimalType.FOX]

var minx = 100000
var maxx = -100000
var miny = 100000
var maxy = -100000

func _ready():
	# Singleton
	if instance == null:
		instance = self
	else:
		queue_free()
		return
	
	# Compute the bounds of the area2D
	for child in area2D.get_children():
		if child is CollisionShape2D:
			var shape = child.shape as RectangleShape2D
			minx = min(minx, child.position.x - shape.size.x / 2)
			maxx = max(maxx, child.position.x + shape.size.x / 2)
			miny = min(miny, child.position.y - shape.size.y / 2)
			maxy = max(maxy, child.position.y + shape.size.y / 2)
	print("Bounds: ", minx, ", ", maxx, ", " , miny, ", " , maxy)

func spawn_predator(type: PackedScene, at: Vector2) -> void:
	var predator: Predator = type.instantiate()
	predator.target_stack = vivier
	add_child(predator)
	predator.global_position = at


func _on_timer_timeout():
	if area2D == null:
		print("Set area2D child")
		return
	else:
		var x = randf_range(minx, maxx)
		var y = randf_range(miny, maxy)
		var at = global_position + Vector2(x, y)
		var type = (1 + 
					randi() % (max_animal_level[LevelNumber.level_number-1]))
					
		spawn_predator(predator_scenes[type], at)
