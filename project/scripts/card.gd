extends Area2D

const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

const _xOffset = 105
const _yOffset = 130

var _suit = Suit.NONE
var _symbol = Symbol.NONE

func setCardType(suit:Suit, symbol:Symbol):
	_suit = suit
	_symbol = symbol
	
	var x = 0;
	var y = 0;
	
	if (_suit == Suit.NONE) and (_symbol == Symbol.NONE):
		x = _xOffset
		y = _yOffset
	elif (_suit == Suit.NONE) and (_symbol == Symbol.JOKER):
		x = 0
		y = _yOffset
	else:
		x = (_symbol - 1) * _xOffset
		y = (_suit - 1) * _yOffset

	$Sprite2D.region_rect.position.x = x
	$Sprite2D.region_rect.position.y = y
