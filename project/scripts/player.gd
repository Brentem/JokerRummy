extends Node2D

class_name Player

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

# TODO: Make it so that this variable isn't necesary anymore.
var hasTurn : bool = false

enum State
{
	Idle,
	PickingCards,
	LayingCards,
	TurnIsOver
}

var state : State = State.Idle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# NOTE: This functions is not used currently.
func AddCard(cardInfo: CardInfo, position: Vector2) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(cardInfo)
	card.position = position
	add_child(card)
