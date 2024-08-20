extends Node2D

@export var card_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var xPosition = 50
	var yPosition = 50
	
	for i in 15:
		var card = card_scene.instantiate()
		card.position.x = xPosition
		card.position.y = yPosition
		card.get_node("Sprite2D").hframes = 9
		card.get_node("Sprite2D").vframes = 2
		card.get_node("Sprite2D").frame = i
		xPosition += 100
		
		if(i == 10):
			xPosition = 50
			yPosition = 200
		add_child(card)
	
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
