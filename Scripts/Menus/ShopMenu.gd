extends Control

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Global.items.size()):
		var itemBtn = preload("res://Scenes/Menus/Button/ItemButton.tscn").instance()
		itemBtn._set_item_name(Global.items[i])
		itemBtn._set_item_price(str(Global.items_price[i]))
		itemBtn._set_item_index(i)
		# Testing texture 
		itemBtn._set_item_icon("res://Art/Sprites/TempCharacters/"+Global.items_icon[0])
		$CenterContainer/GridContainer.add_child(itemBtn)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	pass

func _on_ShopKeeper_close_shop():
	hide()

func _on_ShopKeeper_open_shop():
	show()
