extends TextureButton

class_name InventorySlotUi

@onready var item_texture: TextureRect = $ItemTexture
@onready var selection_border: TextureRect = $SelectionBorder

func set_item(item: InventoryItem):
	item_texture.visible = !!item
	item_texture.texture = item.texture if !!item else null


func set_selected(select: bool):
	selection_border.visible = select
