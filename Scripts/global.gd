# A file for global vars 
extends Node

enum direction {
	moveLeft = -1
	moveRight = 1
}

const items = ["ShotGun","Knife","Assault Rifle","Grenade Launcher","Spear","Laser Gun","Pocket Watch"]
const items_price = [100,50,200,300,100,400,1000]
const items_icon = ["sprite_72.png"]

var dialogues = { # Everytime the player talks with an NPC it will be stored here so the system use the "repeat" block (if available) on the next interaction.
}

var variables = { # Variables used as conditions to know what dialogue block the player should see next. 
}

var stats = {"health": 100, "emeralds": 0, "energy": 100, "bombs": 3}

var inventory = {}