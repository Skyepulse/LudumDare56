extends CharacterBody2D

var speed = 1000
var direction_droite = Vector2(-1, 0)
var direction_gauche = Vector2(1, 0)

var direc: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(direc==1):
		velocity = speed*direction_droite
		move_and_slide()
	else:
		velocity = speed*direction_gauche
		move_and_slide()

