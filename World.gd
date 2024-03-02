extends Node2D

@onready var tileMap = $TileMap
var borders = Rect2(1, 1, 40, 22)

func _ready():
	generate_level()
	
func generate_level():
	pass
