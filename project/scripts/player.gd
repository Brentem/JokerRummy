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
var hasWon : bool = false
