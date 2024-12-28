class_name CardLogic
extends Node

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

const QuartetSize : int = 4
const QuartetMinimumSize : int = 3

static func foo(cards: Array[CardInfo]) -> bool:
	# TODO: 40 points already laid out or not?
	
	return _isQuartet(cards) || _isSeries(cards)

static func _isQuartet(cards: Array[CardInfo]) -> bool:
	if cards.size() > QuartetSize:
		return false
	
	if cards.size() < QuartetMinimumSize:
		return false	
	
	var retVal : bool = false
	
	var firstCard := cards[0]
	var symbolInfo : Array[bool] = [false, false, false, false]
	var suitCounter : Array[int] = [0, 0, 0, 0]
		
	for i in cards.size():
		var temp : bool = cards[i]._symbol == firstCard._symbol
		symbolInfo[cards[i]._suit - 1] = temp
		suitCounter[cards[i]._suit - 1] += 1
		
	var counter : int = 0
	for i in QuartetSize:
		if suitCounter[i] > 1:
			retVal = false
			break
		elif symbolInfo[i] && suitCounter[i] == 1:
			counter += 1
		
	retVal = counter >= 3
		
	return retVal

static func _isSeries(cards: Array[CardInfo]) -> bool:
	var sorted := _sortCards(cards)
	if !sorted:
		return false
	
	var retVal : bool = false
	var prevCard := cards[0]
	var currCard := cards[1]
	
	for i in range(2, cards.size()):
		if (prevCard._symbol + 1) == (currCard._symbol):
			retVal = true
		else:
			retVal = false
			break
		
		prevCard = currCard
		currCard = cards[i]
	
	return retVal

# NOTE: Made this function because sort function of Array doesn't work
static func _sortCards(cards: Array[CardInfo]) -> bool:
	var suit : Suit = cards[0]._suit
	for i in cards.size():
		if cards[i]._suit != suit:
			return false
	
	var symbols : Array[Symbol]
	for i in cards.size():
		symbols.append(cards[i]._symbol)
		
	symbols.sort() # NOTE: This does work, probably because it's solely an enum.
	
	var newCards : Array[CardInfo]
	for i in cards.size():
		var newCard := CardInfo.new()
		newCard._suit = suit
		newCard._symbol = symbols[i]
		newCards.append(newCard)
		
	cards.clear()
	cards.append_array(newCards)
	
	return true
