# A file for global vars 
extends Node

enum direction {
	moveLeft = -1
	moveRight = 1
}

var dialogues = { # Everytime the player talks with an NPC it will be stored here so the system use the "repeat" block (if available) on the next interaction.
}

var variables = { # Variables used as conditions to know what dialogue block the player should see next. 
}

var shop_items = {}

var stats = {"health": 100, "emeralds": 0, "energy": 100, "bombs": 3}

var inventory = {}


func _ready():
	addItemsToShop("ShotGun", 1, "sprite_72.png")
	addItemsToShop("Knife", 1, "sprite_72.png")
	addItemsToShop("Assault Rifle", 1, "sprite_72.png")
	addItemsToShop("Grenade Launcher", 1, "sprite_72.png")
	addItemsToShop("Spear", 1, "sprite_72.png")
	addItemsToShop("Laser Gun", 1, "sprite_72.png")
	addItemsToShop("Pocket Watch", 1, "sprite_72.png")
	
func addItemsToShop(item_name, item_price, item_icon):
	shop_items[item_name] = {"item_price": item_price, "item_icon": item_icon}