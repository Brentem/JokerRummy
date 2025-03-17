extends MarginContainer

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo

func add_card(card_info: CardInfo) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(card_info)
	var patch_rect : NinePatchRect = NinePatchRect.new()
	patch_rect.texture = card.get_node("Sprite2D").texture
	patch_rect.region_rect = card.get_node("Sprite2D").region_rect
	patch_rect.custom_minimum_size = patch_rect.region_rect.size
	
	$ScrollContainer/HBoxContainer.add_child(patch_rect)
