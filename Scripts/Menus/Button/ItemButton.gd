extends Control

# Declare member variables here. Examples:
var item_name : String = String()
var item_price : int = 0
var item_incr : int = 0
var item_var : String = String()

signal health
signal energy
signal shots
signal jumps
signal bombs

onready var UI = get_node("../../../../UI") # GridContainer/CenterContainer/ShopMenu/Canvas/UI
# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("pressed", self, "_purchase_item")
	pass # Replace with function body.

func _set_item_name(name):
	item_name = name
	
func _set_item_price(price):
	item_price = price
	$Button/item_price.text = str(price)
	
func _set_item_icon(icon_path):
	$Button/item_icon.texture = load(icon_path)
	get_node("Button/item_icon").scale = Vector2(0.75,0.75)

func _set_item_var(item_variable):
	item_var = item_variable

func _set_item_increment(increment):
	item_incr = increment
	
func _update_name():
	$Button/slot_name.text = item_name + " (+" + str(item_incr) + ")"
	
func _purchase_item():
	print("Player tries to purchase " + item_name + " for $" + str(item_price))
	if Global.stats["emeralds"] >= item_price:
		Global.stats["emeralds"] -= item_price
		if Global.stats.has(item_var):
			Global.stats[item_var] += item_incr	
		elif Global.inventory.has(item_name):
			Global.inventory[item_name] += item_incr
		else:
			Global.inventory[item_name] = item_incr
		if UI != null:
			UI.update_emerald(Global.stats["emeralds"])
			UI.update_variables(item_name, Global.stats[item_var] if Global.stats.has(item_var) else Global.inventory[item_name])
#		print("Player purchased " + item_name + " totaling of " + str(Global.inventory[item_name]))
