extends Node2D

@onready var text =$most_interesting_content
var text_num = 0
var max_tex = 3
var texts = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_num = 0# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await get_tree().create_timer(4).timeout
	if text_num < max_tex :
		show_text(text_num)
		text_num+=1
	else :
		get_tree().change_scene_to_file("res://Level Scenes/tutorial.tscn")

func show_text(i : int ) -> void :
	text.clear()
	text.add_text(texts[i])
