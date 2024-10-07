extends Control


@onready var time_label: RichTextLabel = $Control/Control/HBoxContainer/Time/RichTextLabel
@onready var points_label: RichTextLabel = $Control/Control/HBoxContainer/Points/RichTextLabel

func _ready():
	time_label.add_theme_font_size_override("font_size", 24)
	points_label.add_theme_font_size_override("font_size", 24)

func _process(_delta: float):
	if WinningLine.instance != null:
		update_labels()

func update_labels():
	if WinningLine.instance.get_game_state() == WinningLine.GameState.WIN:
		time_label.text = "You won!"
		points_label.text = "%d/%d" % [WinningLine.instance.total_needed_points, WinningLine.instance.total_needed_points]
		return
	elif WinningLine.instance.get_game_state() == WinningLine.GameState.LOSE:
		time_label.text = "You lost!"
		points_label.text = "%d/%d" % [min(WinningLine.instance.total_current_points, WinningLine.instance.total_needed_points), WinningLine.instance.total_needed_points]
		return
	var timeLeft = WinningLine.instance.time_left
	var minutes = int(timeLeft / 60)
	var seconds = int(int(timeLeft) % 60)
	time_label.text = "Time: %d:%02d" % [minutes, seconds]
	points_label.text = "%d/%d" % [min(WinningLine.instance.total_current_points, WinningLine.instance.total_needed_points), WinningLine.instance.total_needed_points]
