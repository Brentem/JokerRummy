extends Node

class_name Deck

var _deckElements = []

func _init():
	for i in 2:
		for suitNumber in 4:
			var suitEnum : CardTypes.Suit = suitNumber + 1
			for symbolNumber in 13:
				var symbolEnum : CardTypes.Symbol = symbolNumber + 1
				var cardTemp := CardTypes.CardTemp.new()
				cardTemp._suit = suitEnum
				cardTemp._symbol = symbolEnum
				_deckElements.append(cardTemp)
	
	for i in 4:
		var joker : CardTypes.CardTemp = CardTypes.CardTemp.new()
		joker._symbol = CardTypes.Symbol.JOKER
		_deckElements.append(joker)
	
	_deckElements.shuffle()
