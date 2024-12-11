class_name UILogic
extends Node

const Symbol = CardTypes.Symbol
const Suit = CardTypes.Suit
const CardInfo = CardTypes.CardInfo

var _deck : Deck

var _playerCards := []
var _heapCards : Array[CardInfo] = []
var _tableCards : Array[CardInfo] = []

var _playerList : Array[ItemList] = []
var _heapList : ItemList
var _tableList : ItemList
var _deckList : ItemList

var _load : bool = true;

func _init(deck: Deck, playerList : Array[ItemList],
 heapList: ItemList, tableList: ItemList, deckList: ItemList):
	_deck = deck
	_playerList = playerList
	_heapList = heapList
	_tableList = tableList
	_deckList = deckList
	
	var test : Array[CardInfo] = []
	_playerCards.append(test.duplicate(true))
	_playerCards.append(test.duplicate(true))
	
	for i in 13:
		_playerCards[0].append(_deck.GetCardFromDeck())
		_playerCards[1].append(_deck.GetCardFromDeck())
	
	_heapCards.append(_deck.GetCardFromDeck())

# Public functions:
func Load() -> void:
	if _load == false:
		return
		
	_load = false
	
	for i in _playerList.size():
		_playerList[i].clear()
		for j in _playerCards[i].size():
			_playerList[i].add_item(_playerCards[i][j].to_string())
		
	_heapList.clear()
	for item in _heapCards:
		_heapList.add_item(item.to_string())
		
	_tableList.clear()
	for item in _tableCards:
		_tableList.add_item(item.to_string())
		
	_deckList.clear()
	for element in _deck._deckElements:
		_deckList.add_item(element.to_string());

func TakeCardFromDeck(id: int) -> void:
	_playerCards[id].append(_deck.GetCardFromDeck())
	_load = true
	
func PutCardOnHeap(playerId: int) -> void:
	var cardId := playerCardSelected(playerId)
	var card : CardInfo = _playerCards[playerId].pop_at(cardId)
	_heapCards.append(card)
	_load = true
	
func LayCardsOnTable(playerId: int) -> void:
	var cardIds := playerCardsSelected(playerId)
	var cards : Array[CardInfo]
	
	for cardId in cardIds:
		cards.append(createCardInfoCopy(_playerCards[playerId][cardId]))
	
	# TODO: Check if cards are allowed to be placed on the table
	var layCardsOnTable = CardLogic.foo(cards)
	
	# Put cards on table
	for cardId in cardIds:
		_tableCards.append(createCardInfoCopy(_playerCards[playerId][cardId]))
		_playerCards[playerId][cardId]._suit = Suit.NONE
		_playerCards[playerId][cardId]._symbol = Symbol.NONE
	var count := 0
	for cardId in cardIds:
		_playerCards[playerId].remove_at(cardId - count)
		count += 1
	_load = true

func TradeHeap(playerId: int) -> void:
	var cardId := playerCardSelected(playerId)
	var selectedCard : CardInfo = _playerCards[playerId].pop_at(cardId)
	var heapCard : CardInfo = _heapCards.pop_front()
	
	_heapCards.append(selectedCard)
	_playerCards[playerId].append(heapCard)
	_load = true

# Private functions:
func playerCardSelected(playerId: int) -> int:
	var count := 0
	var val := 0
	
	for i in _playerList[playerId].item_count:
		if _playerList[playerId].is_selected(i):
			count += 1
			val = i
			
	if (count > 1) || (count == 0):
		return -1
	
	return val

func playerCardsSelected(playerId:) -> Array[int]:
	var val : Array[int] = []
	
	for i in _playerList[playerId].item_count:
		if _playerList[playerId].is_selected(i):
			val.append(i)
	
	return val

func createCardInfoCopy(src: CardInfo) -> CardInfo:
	var dest := CardInfo.new()
	dest._suit = src._suit
	dest._symbol = src._symbol
	return dest
