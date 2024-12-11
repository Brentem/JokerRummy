class_name CardLogic
extends Node

const CardInfo = CardTypes.CardInfo

const QuartetSize : int = 4

static func foo(cards: Array[CardInfo]) -> bool:
	# TODO: 40 points already laid out or not?
	
	# TODO: Is it a quartet or 3 cards of it?
	if cards.size() <= QuartetSize:
		var firstCard := cards[0]
		var symbolInfo : Array[bool]
		var suitCounter : Array[int] = [0, 0, 0, 0]
		
		for i in QuartetSize:
			var temp : bool = cards[i]._symbol == firstCard._symbol
			symbolInfo.append(temp)
			suitCounter[cards[i]._suit - 1] += 1
	
	# TODO: Is it a series or part of it?
	
	return true
