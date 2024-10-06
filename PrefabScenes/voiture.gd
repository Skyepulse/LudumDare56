extends CharacterBody2D

var speed = 1000
var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = speed*direction
	move_and_slide()
