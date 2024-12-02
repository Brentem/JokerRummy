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

enum Event
{
	NoEvent,
	PickDeckButtonEvent,
	PickHeapButtonEvent, #TODO: Make use of this
	TradeHeapButtonEvent, #TODO: Make use of this
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
	var playerList : Array[ItemList]
	playerList.append($ItemLists/PlayerOneList)
	playerList.append($ItemLists/PlayerTwoList)
	
	var deck : Deck = Deck.new()
	uiLogic = UILogic.new(deck, playerList, $ItemLists/HeapList, $ItemLists/TableList, $ItemLists/DeckList)
	
	var players : Array[Player]
	players.append($Player1)
	players.append($Player2)
	playerStateMachine = PlayerStateMachine.new(players, uiLogic)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var event : Event = Event.NoEvent if eventQueue.is_empty() else eventQueue.pop_front()
	playerStateMachine.Run(event)
	
	guiController.SetTurnText($Text/TurnText, playerStateMachine.GetCurrentPlayerId())
	
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
