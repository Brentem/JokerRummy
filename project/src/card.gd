extends CardTypes

class_name Card

var _suit = Suit.NONE
var _symbol = Symbol.NONE

var _texture : Texture2D
var _position : Vector2 = Vector2(0, 0)
var _region : Rect2

func _init(suit:Suit, symbol:Symbol, texture:Texture2D, position:Vector2):
	_suit = suit
	_symbol = symbol
	_texture = texture
	_position = position
