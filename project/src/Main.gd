extends Node2D

@export var card_scene : PackedScene

var deck = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var xPosition = 50
	var yPosition = 50
	var xRegion = 50

	var texture = card_scene.instantiate().get_node("Sprite2D").texture
	var region = Rect2(Vector2(0, 0), Vector2(50, 100))
	
	for i in 15:
		var card = Card.new(CardTypes.Suit.NONE, CardTypes.Symbol.NONE, texture, Vector2(xPosition, yPosition))
		card._region = region
		xPosition += 100
		region.position.x += xRegion
		
		if(i == 10):
			region.position.y = 100
			region.position.x = 0
			xPosition = 50
			yPosition = 200
		deck.append(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	for i in deck.size():
		var card = deck[i]
		var texturePosition = Rect2(card._position.x, card._position.y, card._region.size.x, card._region.size.y)
		draw_texture_rect_region(card._texture, texturePosition, card._region)
