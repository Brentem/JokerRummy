extends MarginContainer

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo

func add_card(card_info: CardInfo, row_id: int) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(card_info)
	var patch_rect : NinePatchRect = NinePatchRect.new()
	patch_rect.texture = card.get_node("Sprite2D").texture
	patch_rect.region_rect = card.get_node("Sprite2D").region_rect
	patch_rect.custom_minimum_size = patch_rect.region_rect.size
	
	if row_id == 1:
		$VBoxContainer/RowContainer1.add_child(patch_rect)
	elif row_id == 2:
		$VBoxContainer/RowContainer2.add_child(patch_rect)
