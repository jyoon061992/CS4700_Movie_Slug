extends Control

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in Global.shop_items:
		var itemBtn = preload("res://Scenes/Menus/Button/ItemButton.tscn").instance()
		var item = Global.shop_items[key]
		itemBtn._set_item_name(key)
		itemBtn._set_item_price(item["item_price"])
		itemBtn._set_item_icon("res://Art/Sprites/TempCharacters/"+item["item_icon"])
		$CenterContainer/GridContainer.add_child(itemBtn)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
#	pass

func _on_ShopKeeper_close_shop():
	hide()

func _on_ShopKeeper_open_shop():
	show()
