extends Node

#References
@onready var vivier_reference: Vivier = null
@onready var slugLabel: RichTextLabel = $Control/Control/HBoxContainer/slugContainer/RichTextLabel
@onready var betterSlugLabel: RichTextLabel = $Control/Control/HBoxContainer/betterSlugContainer/RichTextLabel
@onready var toadLabel: RichTextLabel = $Control/Control/HBoxContainer/toadContainer/RichTextLabel
@onready var snakeLabel: RichTextLabel = $Control/Control/HBoxContainer/snakeContainer/RichTextLabel
@onready var chickenLabel: RichTextLabel = $Control/Control/HBoxContainer/chickenContainer/RichTextLabel
@onready var foxLabel: RichTextLabel = $Control/Control/HBoxContainer/foxContainer/RichTextLabel
@onready var alienLabel: RichTextLabel = $Control/Control/HBoxContainer/alienContainer/RichTextLabel

func _ready():
	find_root()

func _process(_delta: float):
	if vivier_reference != null:
		update_labels()

func find_root():
	if Vivier.instance != null:
		vivier_reference = Vivier.instance
	else:
		print("Vivier not found")

func update_labels():
	var animal_count: Dictionary = vivier_reference.animal_dictionary
	slugLabel.text = str(animal_count[Animal.AnimalType.SLUG])
	betterSlugLabel.text = str(animal_count[Animal.AnimalType.BETTER_SLUG])
	toadLabel.text = str(animal_count[Animal.AnimalType.TOAD])
	snakeLabel.text = str(animal_count[Animal.AnimalType.SNAKE])
	chickenLabel.text = str(animal_count[Animal.AnimalType.CHICKEN])
	foxLabel.text = str(animal_count[Animal.AnimalType.FOX])
	alienLabel.text = str(animal_count[Animal.AnimalType.ALIEN])
