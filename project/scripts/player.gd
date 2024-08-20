extends Node2D

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AddCard(cardInfo: CardInfo, position: Vector2) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(cardInfo)
	card.position = position
	add_child(card)
