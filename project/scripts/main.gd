extends Node2D

const CardInfo = CardTypes.CardInfo

const cardOffset := 150

const DeckButton := "DeckButton"
const HeapButton := "HeapButton"

var deck : Deck = Deck.new()
var playerList : Array[ItemList] = []
var playerCards := []
var heapCards : Array[CardInfo] = []
var loadLists : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
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
	if loadLists:
		loadLists = false
		for i in $TurnSystem.players.size():
			playerList[i].clear()
			for j in playerCards[i].size():
				playerList[i].add_item(playerCards[i][j].to_string())
		
		$ItemLists/HeapList.clear()
		for item in heapCards:
			$ItemLists/HeapList.add_item(item.to_string())
	
	for i in $TurnSystem.players.size():
		if $TurnSystem.players[i].takingCardFromDeck:
			playerCards[i].append(deck.GetCardFromDeck())
			loadLists = true
			$TurnSystem.players[i].actionTaken = true
			$TurnSystem.players[i].takingCardFromDeck = false
		elif $TurnSystem.players[i].puttingCardOnHeap:
			var id := playerCardSelected(i)
			var card : CardInfo = playerCards[i].pop_at(id)
			heapCards.append(card)
			loadLists = true
			$TurnSystem.players[i].puttingCardOnHeap = false
			$TurnSystem.players[i].allowedToPassTurn = true

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
