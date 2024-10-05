extends Node

const points = {
	Animal.AnimalType.SLUG: 5,
	Animal.AnimalType.BETTER_SLUG: 10,
	Animal.AnimalType.TOAD: 20,
	Animal.AnimalType.SNAKE: 40,
	Animal.AnimalType.CHICKEN: 80,
	Animal.AnimalType.FOX: 160,
	Animal.AnimalType.ALIEN: 320
}

signal win
signal lose
signal points_added

@export var total_needed_points: int = 25
@export var time_to_win: int = 180 # seconds, 3 minutes by default

@onready var area2D: Area2D = $WinningArea


var total_current_points: int = 0
var timer: Timer = null

var time_left: float:
    get: return timer.time_left

var has_won: bool = false
var has_lost: bool = false

func _ready():
    area2D.body_entered.connect(on_body_entered)

    # Debug signals
    points_added.connect(debug_points)
    win.connect(debug_winner)
    lose.connect(debug_loser)

    timer = Timer.new()
    timer.set_wait_time(time_to_win)
    timer.set_one_shot(true)
    timer.timeout.connect(check_win)
    add_child(timer)
    timer.start()

func _process(_delta):
    pass

func on_body_entered(body: Node):
    if body is Animal:
        add_points((body as Animal).type)
        emit_signal("points_added")

func add_points(animal_type: Animal.AnimalType):
    total_current_points += points[animal_type]
    check_win()

func check_win():
    if total_current_points >= total_needed_points:
        has_won = true
        emit_signal("win")
    elif time_left > 0:
        return
    else:
        has_lost = true
        emit_signal("lose")

func debug_points():
    print("Total points: ", total_current_points)
    print("Time left: ", time_left)
    print("Has won: ", has_won)
    print("Total needed points: ", total_needed_points)
    print("Time to win: ", time_to_win)

func debug_loser():
    print("You lost!")

func debug_winner():
    print("You won!")