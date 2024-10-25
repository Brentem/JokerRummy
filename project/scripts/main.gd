extends Node2D

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

const cardOffset := 150

const DeckButton := "DeckButton"
const HeapButton := "HeapButton"
const TableButton := "TableButton"

var deck : Deck = Deck.new()
var players : Array[Player] = []
var playerList : Array[ItemList] = []
var playerCards := []
var heapCards : Array[CardInfo] = []
var tableCards : Array[CardInfo] = []
var loadLists : bool = false

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO: This will do nothing yet.
	for player in players:
		$PlayerStateMachine.Run(player)
	
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
	
	for i in $TurnSystem.players.size():
		#NOTE: This is part of player PickingCards state
		if $TurnSystem.players[i].takingCardFromDeck:
			#NOTE: Perhaps handle DeckButtonEvent in state
			#NOTE: Perhaps handle HeapButtonEvent in state
			playerCards[i].append(deck.GetCardFromDeck())
			loadLists = true
			$TurnSystem.players[i].actionTaken = true
			$TurnSystem.players[i].takingCardFromDeck = false
		#NOTE: This is part of LayingCards state & trigger for TurnIsOver state
		elif $TurnSystem.players[i].puttingCardOnHeap:
			var id := playerCardSelected(i)
			var card : CardInfo = playerCards[i].pop_at(id)
			heapCards.append(card)
			loadLists = true
			$TurnSystem.players[i].puttingCardOnHeap = false
			$TurnSystem.players[i].allowedToPassTurn = true
		#NOTE: This is part of LayingCards state
		elif $TurnSystem.players[i].layingCardsOnTable:
			var ids := playerCardsSelected(i)
			for id in ids:
				tableCards.append(createCardInfoCopy(playerCards[i][id]))
				playerCards[i][id]._suit = Suit.NONE
				playerCards[i][id]._symbol = Symbol.NONE
			var count := 0
			for id in ids:
				playerCards[i].remove_at(id - count)
				count += 1
			$TurnSystem.players[i].layingCardsOnTable = false
			$TurnSystem.players[i].actionTaken = true
			loadLists = true

	if deck._elementTaken:
		deck._elementTaken = false
		$ItemLists/DeckList.clear()
		for element in deck._deckElements:
			$ItemLists/DeckList.add_item(element.to_string());

func _on_turn_button_pressed(id: int) -> void:
	$TurnSystem.SwitchTurns(id)

func _on_action_button_pressed(button_type: String, id: int) -> void:
	if button_type == DeckButton:
		$TurnSystem.DeckAction(id)
	elif button_type == HeapButton:
		$TurnSystem.HeapAction(id)
	elif button_type == TableButton:
		$TurnSystem.TableAction(id)

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
