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
