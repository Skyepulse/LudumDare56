extends AnimatedSprite2D

class_name Animal

enum AnimalType {
    SLUG = 0,
    BETTER_SLUG= 1,
    TOAD =2,
    SNAKE = 3,
    CHICKEN = 4,
    FOX = 5,
    ALIEN = 6
}

@export var speed : int
@export var size : int
@export var throw_distance : int
@export var reproduction_rate : int
@export var type : AnimalType
