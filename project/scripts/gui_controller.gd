class_name GUIController
extends Node

const stringBase: String = "Turn of "
const player1Base: String = "Player 1"
const player2Base: String = "Player 2"

var playerStrings : Array[String] = ["Player 1", "Player 2"]

func SetTurnText(turnText: TextEdit, id: int) -> void:
	turnText.text = stringBase + playerStrings[id]

func SetWinningText(text: TextEdit, id: int) -> void:
	text.text = playerStrings[id] + " has won!"
