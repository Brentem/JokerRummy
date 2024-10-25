extends Node

const State := Player.State
const Event := Main.Event

#TODO: Maybe pass event enum, for instate DeckButtonEvent
func Run(player: Player, event: Event) -> void:
	match player.state:
		State.Idle:
			pass #TODO: Implement
		State.PickingCards:
			handlePickingCardsState(player, event)
		State.LayingCards:
			handleLayingCardsState(player, event)
		State.TurnIsOver:
			pass #TODO: Implement

func handlePickingCardsState(player: Player, event: Event) -> void:
	if event == Event.PickDeckButtonEvent:
		player.state = State.LayingCards
		$"..".TakeCardFromDeck() #NOTE: $".." = Main node
	elif event == Event.PickHeapButtonEvent:
		pass #TODO: Implement

func handleLayingCardsState(player: Player, event: Event) -> void:
	if event == Event.LayTableButtonEvent:
		$"..".LayCardsOnTable() #NOTE: $".." = Main node
	elif event == Event.LayHeapButtonEvent:
		player.state = State.TurnIsOver
		$"..".PutCardOnHeap() #NOTE: $".." = Main node

func handleTurnIsOverState(player: Player, event: Event) -> void:
	if event == Event.TurnButtonEvent:
		pass
