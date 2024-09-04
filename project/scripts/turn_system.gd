extends Node

const stringBase: String = "Turn of "
const player1Base: String = "Player 1"
const player2Base: String = "Player 2"

var player1Turn: bool = true
var player2Turn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player1Turn:
		$"../TextEdit".text = stringBase + player1Base
	elif player2Turn:
		$"../TextEdit".text = stringBase + player2Base
	pass


func _on_button_1_pressed() -> void:
	player1Turn = false
	player2Turn = true
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	player1Turn = true
	player2Turn = false
	pass # Replace with function body.
