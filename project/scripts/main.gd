extends Node2D

const CardInfo = CardTypes.CardInfo

const cardOffset := 150

var deck : Deck = Deck.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var cardOnePosition := Vector2(-800, 150)
	var cardTwoPosition := Vector2(-800, -150)
	
	for i in 13:
		$Player1.AddCard(deck.GetCardFromDeck(), cardOnePosition)
		$Player2.AddCard(deck.GetCardFromDeck(), cardTwoPosition)
		cardOnePosition.x += 130
		cardTwoPosition.x += 130

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
