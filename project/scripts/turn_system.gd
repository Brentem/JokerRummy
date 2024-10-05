extends Node

const stringBase: String = "Turn of "
const player1Base: String = "Player 1"
const player2Base: String = "Player 2"

var players : Array[Player] = []
var playerStrings : Array[String] = ["Player 1", "Player 2"]

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

func SwitchTurns(id: int) -> void:
	if id >= players.size():
		return
		
	if players[id].hasTurn and players[id].allowedToPassTurn:
		for player in players:
			player.hasTurn = false
			player.actionTaken = false
			player.allowedToPassTurn = false
		
		var index := id + 1
		if index == players.size():
			index = 0
			
		players[index].hasTurn = true

func DeckAction(id: int) -> void:
	var player := players[id]
	
	if player.actionTaken and player.hasTurn:
		return
	
	player.takingCardFromDeck = true

func HeapAction(id: int) -> void:
	var player := players[id]
	
	if !player.actionTaken and player.hasTurn:
		return
	
	if player.allowedToPassTurn:
		return
	
	player.puttingCardOnHeap = true

func TableAction(id: int) -> void:
	var player := players[id]
	
	if player.actionTaken and player.hasTurn:
		return
		
	player.layingCardsOnTable = true
