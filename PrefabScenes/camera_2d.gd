extends Camera2D

@export var position_camera: Vector2
@export var size_camera: Vector2
@export var top_left_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_camera = get_screen_center_position()
	size_camera = get_viewport_rect().size
	top_left_position = (position_camera - (0.5*size_camera))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
