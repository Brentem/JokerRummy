class_name Deck
extends Node

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

var _deckElements : Array[CardInfo]= []
var _elementTaken : bool = false;

func _init(shuffle : bool):
	fillDeckElements()
	
	if shuffle:
		_deckElements.shuffle()

func GetCardFromDeck() -> CardInfo:
	_elementTaken = true;
	return _deckElements.pop_back()

func fillDeckElements() -> void:
	for i in 2:
		for suitNumber in 4:
			var suitEnum : Suit = suitNumber + 1
			for symbolNumber in 13:
				var symbolEnum : Symbol = symbolNumber + 1
				var cardInfo := CardInfo.new()
				cardInfo._suit = suitEnum
				cardInfo._symbol = symbolEnum
				_deckElements.append(cardInfo)
	
	for i in 4:
		var joker : CardInfo = CardInfo.new()
		joker._symbol = Symbol.JOKER
		_deckElements.append(joker)
