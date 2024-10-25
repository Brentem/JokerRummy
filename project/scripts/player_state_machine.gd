extends Node

const State := Player.State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#TODO: Maybe pass event enum, for instate DeckButtonEvent
func Run(player: Player) -> void:
	match player.state:
		State.Idle:
			pass #TODO: Implement
		State.PickingCards:
			pass #TODO: Implement
		State.LayingCards:
			pass #TODO: Implement
		State.TurnIsOver:
			pass #TODO: Implement
