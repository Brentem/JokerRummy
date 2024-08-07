extends Node2D

@export var card_scene : PackedScene
var positionCounter = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1, 5):
		for j in 2:
			for k in range(1, 14):
				var card = card_scene.instantiate()
				card.setCardType(i, k)
				card.position = Vector2(positionCounter, positionCounter)
				positionCounter += 20
				add_child(card)
	
	#var joker = Card.new(CardTypes.Suit.NONE, CardTypes.Symbol.JOKER)
	#for i in 4:
		#deck.append(joker)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	pass
