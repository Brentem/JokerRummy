extends Node2D

class_name Player

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

enum State
{
	Idle,
	PickingCards,
	LayingCards,
	TurnIsOver
}

var state : State = State.Idle

# NOTE: This functions is not used currently.
func AddCard(cardInfo: CardInfo, position: Vector2) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(cardInfo)
	card.position = position
	add_child(card)
