extends MarginContainer

@export var card_scene : PackedScene

const CardInfo = CardTypes.CardInfo

var selectedId = 0;
var selected_card_ids : Array[int]

var counter = 0

func add_card(card_info: CardInfo) -> void:
	var card = card_scene.instantiate()
	card.SetCardType(card_info)
	var patch_rect : NinePatchRect = NinePatchRect.new()
	patch_rect.texture = card.get_node("Sprite2D").texture
	patch_rect.region_rect = card.get_node("Sprite2D").region_rect
	patch_rect.custom_minimum_size = patch_rect.region_rect.size
	patch_rect.set_mouse_filter(Control.MOUSE_FILTER_PASS) # This is needed or gui_input signal won't work.
	
	patch_rect.gui_input.connect(_gui_input_card.bind(counter))
	counter += 1

	$ScrollContainer/HBoxContainer.add_child(patch_rect)

func reset() -> void:
	counter = 0
	var children = $ScrollContainer/HBoxContainer.get_children()
	for child in children:
		$ScrollContainer/HBoxContainer.remove_child(child)

func get_card_ids() -> Array[int]:
	selected_card_ids.sort()
	return selected_card_ids

func _gui_input_card(event: InputEvent, id: int) -> void:
	if event.is_pressed() == false:
		return
	
	if selected_card_ids.has(id):
		selected_card_ids.erase(id)
	else:
		selected_card_ids.append(id)
