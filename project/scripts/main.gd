extends Node2D

const CardInfo = CardTypes.CardInfo

const cardOffset := 150

const DeckButton := "DeckButton"

var deck : Deck = Deck.new()
var playerList : Array[ItemList] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# NOTE: Begin of code to add card sprites to scene
	#var cardOnePosition := Vector2(-800, 150)
	#var cardTwoPosition := Vector2(-800, -150)
	#
	#for i in 13:
		#$Player1.AddCard(deck.GetCardFromDeck(), cardOnePosition)
		#$Player2.AddCard(deck.GetCardFromDeck(), cardTwoPosition)
		#cardOnePosition.x += 130
		#cardTwoPosition.x += 130
	# NOTE: End of code to add card sprites to scene
	
	playerList.append($ItemLists/PlayerOneList)
	playerList.append($ItemLists/PlayerTwoList)
	
	for i in 13:
		playerList[0].add_item(deck.GetCardFromDeck().to_string())
		playerList[1].add_item(deck.GetCardFromDeck().to_string())		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in $TurnSystem.players.size():
		if $TurnSystem.players[i].takingCardFromDeck:
			playerList[i].add_item(deck.GetCardFromDeck().to_string())
			$TurnSystem.players[i].actionTaken = true
			$TurnSystem.players[i].takingCardFromDeck = false

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
