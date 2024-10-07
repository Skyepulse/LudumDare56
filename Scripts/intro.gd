extends Node2D

@onready var text =$most_interesting_content
var text_num = 0
var max_tex = 6
var texts = [
			"Your slugs were happy," ,
			"you were happy",
			"One day, they built a road separating your slugs from their feeding field.",
			"Alas! the trucks were too dangerous for you...",
			"And so, you decided to throw the slugs and other visitors accross,",
			" hoping most of them would make it..."]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_num = 0# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func show_text(i : int ) -> void :
	text.clear()
	text.add_text(texts[i])

func do_things()-> void :
	await get_tree().create_timer(4).timeout
	if text_num < max_tex :
		show_text(text_num)
		text_num+=1
	else :
		get_tree().change_scene_to_file("res://Level Scenes/tutorial.tscn")


func _on_timer_timeout() -> void:
	pass # Replace with function body.
func skip() -> void :
	#pour ce rageux de telo
	get_tree().change_scene_to_file("res://Level Scenes/tutorial.tscn")
