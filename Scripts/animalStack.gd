extends Node

class_name Vivier

#----------Singleton Instance----------#
static var instance: Vivier = null
#----------Consts----------#
const reproduce_times = {
	Animal.AnimalType.SLUG: 5,
	Animal.AnimalType.BETTER_SLUG: 7,
	Animal.AnimalType.TOAD: 15,
	Animal.AnimalType.SNAKE: 25,
	Animal.AnimalType.CHICKEN: 35,
	Animal.AnimalType.FOX: 50,
	Animal.AnimalType.ALIEN: 75
}

const max_animals = {
	Animal.AnimalType.SLUG: 10,
	Animal.AnimalType.BETTER_SLUG: 10,
	Animal.AnimalType.TOAD: 7,
	Animal.AnimalType.SNAKE: 5,
	Animal.AnimalType.CHICKEN: 3,
	Animal.AnimalType.FOX: 2,
	Animal.AnimalType.ALIEN: 1
}

var animal_timers = {}

#----------Preloads----------#
var slug: PackedScene = preload("res://Level Scenes/slug.tscn")
var better_slug: PackedScene = preload("res://Level Scenes/better_slug.tscn")
var toad: PackedScene = preload("res://Level Scenes/toad.tscn")
var snake: PackedScene = preload("res://Level Scenes/snake.tscn")
var chicken: PackedScene = preload("res://Level Scenes/chicken.tscn")
var fox: PackedScene = preload("res://Level Scenes/fox.tscn")

#----------Signals----------#
signal animal_added(animal)
signal animal_removed(animal)
signal animal_list_modified()

#----------Members----------#
@export var spawn_position: Vector2
@export var initial_slugs: int = 0
@export var initial_better_slugs: int = 0
@export var initial_toads: int = 0
@export var initial_snakes: int = 0
@export var initial_chickens: int = 0
@export var initial_foxes: int = 0
@export var initial_aliens: int = 0

var animal_list: Array[Animal] = []
var number: int:
	get: return animal_list.size()
var animal_dictionary: Dictionary = {}

@onready var stackArea: Area2D = $Area2D

#----------Methods----------#
func _ready():

	#Singleton
	if instance == null:
		instance = self
	else:
		queue_free()
		return

	#initialize dictionary
	for animalType in Animal.AnimalType.values():
		animal_dictionary[animalType] = 0

	#connect signals
	animal_added.connect(self.start_animal_timer)
	animal_removed.connect(self.stop_animal_timer)
	animal_list_modified.connect(debug_animal_list)
	

	#initialize animals
	init_animals(Animal.AnimalType.SLUG, initial_slugs)
	init_animals(Animal.AnimalType.BETTER_SLUG, initial_better_slugs)
	init_animals(Animal.AnimalType.TOAD, initial_toads)
	init_animals(Animal.AnimalType.SNAKE, initial_snakes)
	init_animals(Animal.AnimalType.CHICKEN, initial_chickens)
	init_animals(Animal.AnimalType.FOX, initial_foxes)
	init_animals(Animal.AnimalType.ALIEN, initial_aliens)

	#Late signals
	stackArea.body_entered.connect(animal_entered_stack)
	stackArea.body_exited.connect(animal_left_stack)
	

func _process(_delta):
	pass

#====================================#
func debug_animal_list():
	var result = "["
	
	for animaltype in Animal.AnimalType.values():
		result += str(animaltype) + " " + str(get_animal_count(animaltype)) + ", "
	
	if result.ends_with(", "):
		result = result.substr(0, result.length() - 2)
		
	result += "]"
	
	#print(result)

func add_animal(animal: Animal):
	animal_list.append(animal)
	animal_dictionary[animal.type] += 1
	emit_signal("animal_added", animal)
	emit_signal("animal_list_modified")

func remove_random_animal(animal_max: Animal.AnimalType):
	var last_kind = -1
	for i in range(animal_max):
		if get_animal_count(i) > 0:
			last_kind = i
			if randf() < 0.5 or i == animal_max - 1:
				break
	if last_kind >= 0:
		remove_animal(last_kind, true)
		print('animal removed ' + str(last_kind))
		
	

func remove_animal(animalType: Animal.AnimalType, kill: bool = false):
	for animal in animal_list:
		if animal.type == animalType:
			animal_list.erase(animal)
			if kill:
				animal.queue_free()
			animal_dictionary[animalType] -= 1
			emit_signal("animal_removed", animal)
			emit_signal("animal_list_modified")
			return
	print('animal not found')

func get_animal_count(animalType: Animal.AnimalType) -> int:
	return animal_dictionary[animalType]

func instantiate_animal(animal_type: Animal.AnimalType):
	var new_animal = null
	match animal_type:
			Animal.AnimalType.SLUG:
				new_animal = slug.instantiate()
			Animal.AnimalType.BETTER_SLUG:
				new_animal = better_slug.instantiate()
			Animal.AnimalType.TOAD:
				new_animal = toad.instantiate()
			Animal.AnimalType.SNAKE:
				new_animal = snake.instantiate()
			Animal.AnimalType.CHICKEN:
				new_animal = chicken.instantiate()
			Animal.AnimalType.FOX:
				new_animal = fox.instantiate()
			Animal.AnimalType.ALIEN:
				new_animal = slug.instantiate()
	if new_animal != null:
		add_child(new_animal)
		new_animal.position = spawn_position
		add_animal(new_animal)
		new_animal.is_in_stack = true

func reproduce_animal(animalType: Animal.AnimalType):
	if get_animal_count(animalType) >= max_animals[animalType]:
		return
		
	if get_animal_count(animalType) < 2:
		instantiate_animal(animalType)
		return

	for i in range(int(get_animal_count(animalType) / 2.0)):
		if(get_animal_count(animalType) >= max_animals[animalType]):
			return
		instantiate_animal(animalType)

func init_animals(animalType: Animal.AnimalType, num: int):
	for i in range(num):
		reproduce_animal(animalType)

#====================================#
func start_animal_timer(animal: Animal):
	var animal_type = animal.type
	if get_animal_count(animal_type) >= 2 and !animal_timers.has(animal_type):
		var timer = Timer.new()
		timer.set_wait_time(reproduce_times[animal_type])
		timer.set_one_shot(false)
		timer.timeout.connect(self._on_timer_timeout.bind(animal_type))
		add_child(timer)
		timer.start()

		animal_timers[animal_type] = timer

func stop_animal_timer(animal: Animal):
	var animal_type = animal.type
	if get_animal_count(animal_type) < 2 and animal_timers.has(animal_type):
		var timer = animal_timers[animal_type]
		if timer != null:
			timer.stop()
			timer.queue_free()
			animal_timers.erase(animal_type)

func _on_timer_timeout(animal_type: Animal.AnimalType):
	reproduce_animal(animal_type)

func animal_entered_stack(animal):
	animal.is_in_stack = true
	pass

func animal_left_stack(animal):
	animal.is_in_stack = false
	pass
