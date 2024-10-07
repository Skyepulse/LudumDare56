extends Node

#References
@onready var vivier_reference: Vivier = null
@onready var slugLabel: RichTextLabel = $Control/Control/GridContainer/slugContainer/RichTextLabel
@onready var toadLabel: RichTextLabel = $Control/Control/GridContainer/toadContainer/RichTextLabel
@onready var snakeLabel: RichTextLabel = $Control/Control/GridContainer/snakeContainer/RichTextLabel
@onready var chickenLabel: RichTextLabel = $Control/Control/GridContainer/chickenContainer/RichTextLabel
@onready var foxLabel: RichTextLabel = $Control/Control/GridContainer/foxContainer/RichTextLabel
@onready var alienLabel: RichTextLabel = $Control/Control/GridContainer/alienContainer/RichTextLabel

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
	toadLabel.text = str(animal_count[Animal.AnimalType.TOAD])
	snakeLabel.text = str(animal_count[Animal.AnimalType.SNAKE])
	chickenLabel.text = str(animal_count[Animal.AnimalType.CHICKEN])
	foxLabel.text = str(animal_count[Animal.AnimalType.FOX])
	alienLabel.text = str(animal_count[Animal.AnimalType.ALIEN])
