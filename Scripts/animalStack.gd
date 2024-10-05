extends Node

#----------Consts----------#
const reproduce_times = {
    Animal.AnimalType.SLUG: 0.2,
    Animal.AnimalType.BETTER_SLUG: 0.15,
    Animal.AnimalType.TOAD: 0.1,
    Animal.AnimalType.SNAKE: 0.7,
    Animal.AnimalType.CHICKEN: 0.05,
    Animal.AnimalType.FOX: 0.03,
    Animal.AnimalType.ALIEN: 0.02
}

var animal_timers = {}
#----------Preloads----------#

#----------Signals----------#
signal animal_added(animal: Animal)
signal animal_removed(animal: Animal)

#----------Members----------#
var animalList : Array[Animal] = []
var number: int:
    get: return animalList.size()

#----------Methods----------#
func _ready():
    animal_added.connect(start_animal_timer)
    animal_removed.connect(stop_animal_timer)
func add_animal(animal: Animal):
    animalList.append(animal)
    emit_signal("animal_added", animal)

func remove_animal(animalType: Animal.AnimalType):
    for animal in animalList:
        if animal.type == animalType:
            animalList.erase(animal)
            emit_signal("animal_removed", animal)
            break
    print('animal not found')

func get_animal_count(animalType: Animal.AnimalType):
    var count : int = 0
    for animal in animalList:
        if animal.type == animalType:
            count += 1
    return count

func reproduce_animal(animalType: Animal.AnimalType):
    print('hi', animalType)

#====================================#
func start_animal_timer(animal: Animal):
    var animal_type = animal.type
    if get_animal_count(animal_type) >= 2 and !animal_timers.has(animal_type):
        var timer = Timer.new()
        timer.set_wait_time(reproduce_times[animal_type])
        timer.set_one_shot(false)
        timer.timeout.connect(_on_timer_timeout, [animal_type])
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