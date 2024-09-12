class_name CardTypes

enum Suit
{
	NONE,
	HEARTS,
	CLUBS,
	DIAMONDS,
	SPADES
}

enum Symbol
{
	NONE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE,
	JOKER
}

class CardInfo:
	var _suit : Suit = Suit.NONE
	var _symbol : Symbol = Symbol.NONE
	func _to_string() -> String:
		return "Suit: " + Suit.keys()[_suit] + ", Symbol: " + Symbol.keys()[_symbol]
