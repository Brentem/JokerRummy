extends Node2D

class_name Main

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

const cardOffset := 150

const DeckButton := "DeckButton"
const HeapButton := "HeapButton"
const TableButton := "TableButton"

enum Event
{
	NoEvent,
	PickDeckButtonEvent,
	PickHeapButtonEvent, #TODO: Make use of this
	LayTableButtonEvent,
	LayHeapButtonEvent,
	TurnButtonEvent
}

var deck : Deck = Deck.new()
var players : Array[Player] = []
var playerList : Array[ItemList] = []
var playerCards := []
var heapCards : Array[CardInfo] = []
var tableCards : Array[CardInfo] = []
var loadLists : bool = false

var eventQueue : Array[Event] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	players.append($Player1)
	players.append($Player2)
	
	playerList.append($ItemLists/PlayerOneList)
	playerList.append($ItemLists/PlayerTwoList)
	
	var test : Array[CardInfo] = []
	playerCards.append(test.duplicate(true))
	playerCards.append(test.duplicate(true))
	
	for i in 13:
		playerCards[0].append(deck.GetCardFromDeck())
		playerCards[1].append(deck.GetCardFromDeck())
	
	heapCards.append(deck.GetCardFromDeck())
	loadLists = true
	
	# TODO: Probably find a better way to do this.
	players[0].state = Player.State.PickingCards

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerId : int = $TurnSystem.playerId
	var event : Event = Event.NoEvent if eventQueue.is_empty() else eventQueue.pop_front()
	$PlayerStateMachine.Run(players[playerId], event)
	
	if loadLists:
		loadLists = false
		for i in $TurnSystem.players.size():
			playerList[i].clear()
			for j in playerCards[i].size():
				playerList[i].add_item(playerCards[i][j].to_string())
		
		$ItemLists/HeapList.clear()
		for item in heapCards:
			$ItemLists/HeapList.add_item(item.to_string())
		
		$ItemLists/TableList.clear()
		for item in tableCards:
			$ItemLists/TableList.add_item(item.to_string())

	if deck._elementTaken:
		deck._elementTaken = false
		$ItemLists/DeckList.clear()
		for element in deck._deckElements:
			$ItemLists/DeckList.add_item(element.to_string());

func _on_turn_button_pressed(id: int) -> void:
	if id != $TurnSystem.playerId:
		return;
	
	eventQueue.append(Event.TurnButtonEvent)

func _on_action_button_pressed(button_type: String, id: int) -> void:
	if id != $TurnSystem.playerId:
		return;
	
	if button_type == DeckButton:
		eventQueue.append(Event.PickDeckButtonEvent)
	elif button_type == HeapButton:
		eventQueue.append(Event.LayHeapButtonEvent)
	elif button_type == TableButton:
		eventQueue.append(Event.LayTableButtonEvent)

func playerCardSelected(playerId: int) -> int:
	var count := 0
	var val := 0
	
	for i in playerList[playerId].item_count:
		if playerList[playerId].is_selected(i):
			count += 1
			val = i
			
	if (count > 1) || (count == 0):
		return -1
	
	return val

func playerCardsSelected(playerId:) -> Array[int]:
	var val : Array[int] = []
	
	for i in playerList[playerId].item_count:
		if playerList[playerId].is_selected(i):
			val.append(i)
	
	return val

func createCardInfoCopy(src: CardInfo) -> CardInfo:
	var dest := CardInfo.new()
	dest._suit = src._suit
	dest._symbol = src._symbol
	return dest

func TakeCardFromDeck() -> void:
	var playerId : int = $TurnSystem.playerId
	playerCards[playerId].append(deck.GetCardFromDeck())
	loadLists = true
	
func PutCardOnHeap() -> void:
	var playerId = $TurnSystem.playerId
	var cardId := playerCardSelected(playerId)
	var card : CardInfo = playerCards[playerId].pop_at(cardId)
	heapCards.append(card)
	loadLists = true
	
func LayCardsOnTable() -> void:
	var playerId : int = $TurnSystem.playerId
	var cardIds := playerCardsSelected(playerId)
	for id in cardIds:
		tableCards.append(createCardInfoCopy(playerCards[playerId][id]))
		playerCards[playerId][id]._suit = Suit.NONE
		playerCards[playerId][id]._symbol = Symbol.NONE
	var count := 0
	for id in cardIds:
		playerCards[playerId].remove_at(id - count)
		count += 1
	loadLists = true
