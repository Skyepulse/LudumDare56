extends CharacterBody2D

var speed = 100
var direction = Vector2(0, -1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity += speed.direction
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
