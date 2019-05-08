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

var stats = {"health": 100, "emeralds": 100, "energy": 100, "bombs": 3, "maxHealth": 100, "maxEnergy":100, "maxJumps":1,"maxShots":1}

var inventory = {}


func _ready():
	#addItemsToShop(item_name, price, image, stats_variablem, increment)
	addItemsToShop("Health", 10, "sprite_72.png", "maxHealth", 10)
	addItemsToShop("Energy", 10, "sprite_72.png", "maxEnergy", 10)
	addItemsToShop("Shots", 25, "sprite_72.png", "maxShots", 1)
	addItemsToShop("Jumps", 30, "sprite_72.png", "maxJumps", 1)
	addItemsToShop("Bombs", 5, "sprite_72.png", "bombs", 1)
	#addItemsToShop("Pocket Watch", 30, "sprite_72.png", "pocketWatch", 1)
	#ddItemsToShop("Grenade Launcher", 5, "sprite_72.png", "g_launcher", 1)
	
func addItemsToShop(item_name, item_price, item_icon, item_var, item_incr):
	shop_items[item_name] = {"item_price": item_price, "item_icon": item_icon, "item_var": item_var, "item_incr": item_incr}