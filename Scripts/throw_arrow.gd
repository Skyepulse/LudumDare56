extends Control

class_name ThrowArrow
@onready var arrowTexture: TextureRect = $Control/TextureRect

var arrow_min_width = 25
var arrow_max_width = 100

var arrow_animation_time:float = 2 # seconds
var time: float = 0

var throw_value: float = 0

func _ready():
	arrowTexture.custom_minimum_size.x = arrow_min_width

func _process(_delta):
	time += _delta
	var half_cycle = arrow_animation_time / 2

	var normalized_time = fposmod(time, arrow_animation_time)

	if normalized_time < half_cycle:
		var t = normalized_time / half_cycle
		arrowTexture.custom_minimum_size.x = lerp(arrow_min_width, arrow_max_width, t)
		throw_value = t
	else:
		var t = (normalized_time - half_cycle) / half_cycle
		arrowTexture.custom_minimum_size.x = lerp(arrow_max_width, arrow_min_width, t)
		throw_value = 1.0 - t
