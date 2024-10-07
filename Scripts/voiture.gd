extends CharacterBody2D

var speed = 1000
var direction_droite = Vector2(-1, 0)
var direction_gauche = Vector2(1, 0)

var direc: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(direc==true):
		velocity = speed*direction_gauche
	else:
		velocity = speed*direction_droite

	var collision = move_and_collide(velocity * delta)
	if collision:
		var animal = collision.get_collider()
		if animal.has_method("squish"):
			animal.squish()
