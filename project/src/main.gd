extends Node2D

@export var card_scene : PackedScene

var deck = []
var clubs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var xPosition = 50
	var yPosition = 50
	var texture = card_scene.instantiate().get_node("Sprite2D").texture
	
	var globalTextures = Global_Textures.new()
	globalTextures.loadTextures()
	clubs = globalTextures.getClubs()
	
	for i in range(1, 5):
		for j in 2:
			for k in range(1, 14):
				var card = Card.new(i, k, texture, Vector2(xPosition, yPosition))
				deck.append(card)
	
	var joker = Card.new(CardTypes.Suit.NONE, CardTypes.Symbol.JOKER, texture, Vector2(xPosition, yPosition))
	for i in 4:
		deck.append(joker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	draw_texture(clubs[0], Vector2(0, 0))
	draw_texture(clubs[5], Vector2(200, 0))
	draw_texture(clubs[10], Vector2(400, 0))
	for i in deck.size():
		var card = deck[i]
		var texturePosition = Rect2(card._position.x, card._position.y, card._region.size.x, card._region.size.y)
		draw_texture_rect_region(card._texture, texturePosition, card._region)
