extends Node
class_name WinningLine

const points = {
	Animal.AnimalType.SLUG: 1,
	Animal.AnimalType.TOAD: 4,
	Animal.AnimalType.SNAKE: 8,
	Animal.AnimalType.CHICKEN: 15,
	Animal.AnimalType.FOX: 20,
	Animal.AnimalType.ALIEN: 50
}

enum GameState {
	WIN,
	LOSE,
	PLAYING
}

# Singleton
static var instance: WinningLine = null

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
	#Singleton
	if instance == null:
		instance = self
	else:
		queue_free()

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
		add_points((body as Animal))
		emit_signal("points_added")

func add_points(animal: Animal):
	if has_won or has_lost:
		return
	total_current_points += points[animal.type]
	animal.spawn_floating_label(points[animal.type], animal.global_position)
	check_win()

func check_win():
	if total_current_points >= total_needed_points:
		has_won = true
		timer.stop()
		emit_signal("win")
	elif time_left > 0:
		return
	else:
		has_lost = true
		timer.stop()
		emit_signal("lose")

func debug_points():
	pass
	#print("Total points: ", total_current_points)
	#print("Time left: ", time_left)
	#print("Has won: ", has_won)
	#print("Total needed points: ", total_needed_points)
	#print("Time to win: ", time_to_win)

func debug_loser():
	#print("You lost!")
	pass

func debug_winner():
	#print("You won!")
	pass

func get_game_state() -> GameState:
	if has_won:
		return GameState.WIN
	elif has_lost:
		return GameState.LOSE
	else:
		return GameState.PLAYING
