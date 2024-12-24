class_name CardLogic
extends Node

const CardInfo = CardTypes.CardInfo

const QuartetSize : int = 4

static func foo(cards: Array[CardInfo]) -> bool:
	# TODO: 40 points already laid out or not?
	
	return _isQuartet(cards) || _isSeries(cards)

static func _isQuartet(cards: Array[CardInfo]) -> bool:
	var retVal : bool = false
	
	if cards.size() <= QuartetSize:
		var firstCard := cards[0]
		var symbolInfo : Array[bool]
		var suitCounter : Array[int] = [0, 0, 0, 0]
		
		for i in QuartetSize:
			var temp : bool = cards[i]._symbol == firstCard._symbol
			symbolInfo.append(temp)
			suitCounter[cards[i]._suit - 1] += 1
		
		var counter : int = 0
		for i in QuartetSize:
			if suitCounter[i] > 1:
				retVal = false
				break
			elif symbolInfo[i] && suitCounter[i] == 1:
				counter += 1
		
		retVal = counter >= 3
	else:
		return false
		
	return retVal

static func _isSeries(cards: Array[CardInfo]) -> bool:
	return true
