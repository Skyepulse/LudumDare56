extends Node

#----------Preloads----------#

#----------Signals----------#
signal animal_added(animal: Animal)
signal animal_removed(animal: Animal)

#----------Members----------#
var animalList : Array[Animal] = []
var number: int:
    get: return animalList.size()

#----------Methods----------#
func add_animal(animal: Animal):
    animalList.append(animal)
    emit_signal("animal_added", animal)

func remove_animal(animal: Animal):
    animalList.erase(animalList.find(animal))
    emit_signal("animal_removed", animal)

