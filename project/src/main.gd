extends Node2D

@export var card_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var xPosition = 0
	var yPosition = 0
	
	for i in 5:
		var card = card_scene.instantiate()
		card.position.x = xPosition
		card.position.y = yPosition
		xPosition += 200
		yPosition += 200
		add_child(card)
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
