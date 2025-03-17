class_name Main
extends Node2D

const CardInfo = CardTypes.CardInfo
const Suit = CardTypes.Suit
const Symbol = CardTypes.Symbol

const cardOffset := 150

const DeckButton := "DeckButton"
const HeapButton := "HeapButton"
const TableButton := "TableButton"
const TradeHeapButton := "TradeHeapButton"

var card_scene = preload("res://scenes/card.tscn")

enum Event
{
	NoEvent,
	PickDeckButtonEvent,
	PickHeapButtonEvent, #TODO: Make use of this
	TradeHeapButtonEvent,
	LayTableButtonEvent,
	LayHeapButtonEvent,
	TurnButtonEvent
}

var guiController : GUIController = GUIController.new()
var playerStateMachine : PlayerStateMachine
var uiLogic : UILogic

var eventQueue : Array[Event] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	debugInit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var gameOver : bool = false
	var winnerId : int = 0
	
	for i in playerStateMachine._players.size():
		if playerStateMachine._players[i].hasWon:
			gameOver = true
			winnerId = i
	
	if !gameOver:
		var event : Event = Event.NoEvent if eventQueue.is_empty() else eventQueue.pop_front()
		playerStateMachine.Run(event)
	
		guiController.SetTurnText($Text/TurnText, playerStateMachine.GetCurrentPlayerId())
	else:
		guiController.SetWinningText($Text/TurnText, winnerId)
	
	uiLogic.Load()

func _on_turn_button_pressed(id: int) -> void:
	if id != playerStateMachine.GetCurrentPlayerId():
		return;
	
	eventQueue.append(Event.TurnButtonEvent)

func _on_action_button_pressed(button_type: String, id: int) -> void:
	if id != playerStateMachine.GetCurrentPlayerId():
		return;
	
	if button_type == DeckButton:
		eventQueue.append(Event.PickDeckButtonEvent)
	elif button_type == HeapButton:
		eventQueue.append(Event.LayHeapButtonEvent)
	elif button_type == TableButton:
		eventQueue.append(Event.LayTableButtonEvent)
	elif button_type == TradeHeapButton:
		eventQueue.append(Event.TradeHeapButtonEvent)


func _on_debug_button_pressed() -> void:
	uiLogic.Reset()
	debugInit(true)

func debugInit(debug: bool) -> void:
	var playerList : Array[ItemList]
	playerList.append($ItemLists/PlayerOneList)
	playerList.append($ItemLists/PlayerTwoList)
	
	var deck : Deck = Deck.new(!debug)
	uiLogic = UILogic.new(deck, playerList, $ItemLists/HeapList, $ItemLists/TableList, $ItemLists/DeckList, debug)
		
	for i in 13:
		$PlayerOneCardsContainer.add_card(uiLogic._playerCards[0][i])

	
	var players : Array[Player]
	players.append($Player1)
	players.append($Player2)
	playerStateMachine = PlayerStateMachine.new(players, uiLogic)
