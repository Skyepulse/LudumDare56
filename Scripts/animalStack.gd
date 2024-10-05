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


    