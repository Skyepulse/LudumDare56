extends Node

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
	Animal.AnimalType.SLUG: 20,
	Animal.AnimalType.BETTER_SLUG: 20,
	Animal.AnimalType.TOAD: 15,
	Animal.AnimalType.SNAKE: 10,
	Animal.AnimalType.CHICKEN: 10,
	Animal.AnimalType.FOX: 5,
	Animal.AnimalType.ALIEN: 3
}

var animal_timers = {}

#----------Preloads----------#
var slug: PackedScene = preload("res://Level Scenes/slug.tscn")

#----------Signals----------#
signal animal_added(animal)
signal animal_removed(animal)
signal animal_list_modified()

#----------Members----------#
var animalList: Array[Animal] = []
var number: int:
	get: return animalList.size()

@export var spawn_position: Vector2

#----------Methods----------#
func _ready():
	animal_added.connect(self.start_animal_timer)
	animal_removed.connect(self.stop_animal_timer)
	animal_list_modified.connect(debug_animal_list)
	init_animals(Animal.AnimalType.SLUG, 2)

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
	animalList.append(animal)
	emit_signal("animal_added", animal)
	emit_signal("animal_list_modified")

func remove_animal(animalType: Animal.AnimalType):
	for animal in animalList:
		if animal.type == animalType:
			animalList.erase(animal)
			emit_signal("animal_removed", animal)
			emit_signal("animal_list_modified")
			return
	print('animal not found')

func get_animal_count(animalType: Animal.AnimalType) -> int:
	var count: int = 0
	for animal in animalList:
		if animal.type == animalType:
			count += 1
	return count

func reproduce_animal(animalType: Animal.AnimalType):
	if get_animal_count(animalType) >= max_animals[animalType]:
		return
		
	if get_animal_count(animalType) < 2:
		match animalType:
			Animal.AnimalType.SLUG:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.BETTER_SLUG:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.TOAD:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.SNAKE:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.CHICKEN:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.FOX:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.ALIEN:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
		return
	for i in range(int(get_animal_count(animalType) / 2)):
		match animalType:
			Animal.AnimalType.SLUG:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.BETTER_SLUG:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.TOAD:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.SNAKE:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.CHICKEN:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.FOX:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)
			Animal.AnimalType.ALIEN:
				var new_animal = slug.instantiate()
				add_child(new_animal)
				new_animal.position = spawn_position
				add_animal(new_animal)

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
