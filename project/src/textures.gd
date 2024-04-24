extends Node

class_name Global_Textures

var clubsTextures = []
var diamondsTextures = []
var heartsTextures = []
var spadesTextures = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func getClubs():
	return clubsTextures

func loadTextures():
	loadClubs()
	loadDiamonds()
	loadHearts()
	loadSpades()

var position = Vector2i(0, 0)
const size = Vector2i(100, 128)
const offset = 128
const frames = 13

func loadClubs():
	var clubs = Image.load_from_file("assets/clubs.png")
	position = Vector2i(0, 0)
	for i in frames:
		var rect = Rect2i(position, size)
		var image = clubs.get_region(rect)
		var texture = ImageTexture.create_from_image(image)
		clubsTextures.append(texture)
		position.y += offset

func loadDiamonds():
	var diamonds = Image.load_from_file("assets/diamonds.png")
	
func loadHearts():
	var hearts = Image.load_from_file("assets/hearts.png")

func loadSpades():
	var spades = Image.load_from_file("assets/spades.png")
