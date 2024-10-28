extends Node

const stringBase: String = "Turn of "
const player1Base: String = "Player 1"
const player2Base: String = "Player 2"

var players : Array[Player] = []
var playerStrings : Array[String] = ["Player 1", "Player 2"]

var playerId : int = 0 #TODO: Use this variable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players.append($"../Player1")
	players.append($"../Player2")
	players[0].hasTurn = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in players.size():
		if players[i].hasTurn:
			$"../Text/TurnText".text = stringBase + playerStrings[i]

func SwitchTurns() -> void:
	players[playerId].state = Player.State.Idle
	players[playerId].hasTurn = false
	playerId += 1
	
	if playerId >= players.size():
		playerId = 0
	
	players[playerId].state = Player.State.PickingCards
	players[playerId].hasTurn = true
