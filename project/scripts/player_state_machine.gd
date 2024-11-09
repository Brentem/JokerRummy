class_name PlayerStateMachine
extends Node

const State := Player.State
const Event := Main.Event

var _uiLogic : UILogic
var _players : Array[Player] = []
var _playerId : int = 0

func _init(players : Array[Player], uiLogic: UILogic):
	_players = players
	_players[_playerId].state = State.PickingCards
	_uiLogic = uiLogic

func Run(event: Event) -> void:
	#match player.state:
	var player : Player = _players[_playerId]
	match player.state:
		State.Idle:
			pass #TODO: Implement
		State.PickingCards:
			handlePickingCardsState(player, event)
		State.LayingCards:
			handleLayingCardsState(player, event)
		State.TurnIsOver:
			handleTurnIsOverState(event)

func GetCurrentPlayerId() -> int:
	return _playerId

func handlePickingCardsState(player: Player, event: Event) -> void:
	# TODO: Add handling for trading cards from heap in the first round.
	if event == Event.PickDeckButtonEvent:
		player.state = State.LayingCards
		_uiLogic.TakeCardFromDeck(_playerId)
	elif event == Event.PickHeapButtonEvent:
		pass #TODO: Implement

func handleLayingCardsState(player: Player, event: Event) -> void:
	if event == Event.LayTableButtonEvent:
		_uiLogic.LayCardsOnTable(_playerId)
	elif event == Event.LayHeapButtonEvent:
		player.state = State.TurnIsOver
		_uiLogic.PutCardOnHeap(_playerId)

func handleTurnIsOverState(event: Event) -> void:
	if event == Event.TurnButtonEvent:
		_players[_playerId].state = State.Idle
		_playerId += 1
		
		if _playerId >= _players.size():
			_playerId = 0
		
		_players[_playerId].state = State.PickingCards
