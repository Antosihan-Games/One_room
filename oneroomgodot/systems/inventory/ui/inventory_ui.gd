extends Control

@onready var inventory: Inventory = preload("res://systems/inventory/player_inventory.tres")
@onready var slots: Array[Node] = %Slots.get_children()
@onready var label_name: Label = %LabelName
@onready var label_description: Label = %LabelDescription

var selected_slot: int = -1

func _ready():
	register_slot_clickhandlers()


func register_slot_clickhandlers():
	for i in range(len(slots)):
		(slots[i] as InventorySlotUi).button_down.connect(select_slot.bind(i))


func update_items():
	if len(slots) != len(inventory.items):
		printerr("inventory items array and slot number must be equal")
		return

	for i in range(len(slots)):
		(slots[i] as InventorySlotUi).set_item(inventory.items[i])


func select_slot(index: int):
	var item = inventory.items[index]

	label_description.text = item.description if item != null else ""
	label_name.text = item.name if item != null else ""

	for i in range(len(slots)):
		(slots[i] as InventorySlotUi).set_selected(i == index)


func open():
	update_items()
	visible = true


func close():
	visible = false


func toggle():
	if visible:
		close()
	else:
		open()


func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		toggle()
