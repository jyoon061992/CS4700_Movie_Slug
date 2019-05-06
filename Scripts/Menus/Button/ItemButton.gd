extends Control

# Declare member variables here. Examples:
var item_name = String()
var item_price = 0
var item_index = 0

onready var UI = get_node("../../../../UI") # GridContainer/CenterContainer/ShopMenu/Canvas/UI
# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", self, "_purchase_item")
	pass # Replace with function body.

func _set_item_name(name):
	item_name = name
	$Button/slot_name.text = name
	
func _set_item_price(price):
	item_price = price
	$Button/item_price.text = str(price)
	
func _set_item_icon(icon_path):
	$Button/item_icon.texture = load(icon_path)
	get_node("Button/item_icon").scale = Vector2(0.75,0.75)
	
func _set_item_index(index):
	item_index = index

func _purchase_item():
	print("Player tries to purchase " + item_name + " for $" + str(item_price) + " at index: " + str(item_index))
	if Global.stats["emeralds"] >= item_price:
		Global.stats["emeralds"] -= item_price
		if UI != null:
			UI._on_player_emerald(Global.stats["emeralds"])
		if Global.inventory.has(item_name):
			Global.inventory[item_name] += 1
		else:
			Global.inventory[item_name] = 1
		print("Player purchased " + item_name + " totaling of " + str(Global.inventory[item_name]))
