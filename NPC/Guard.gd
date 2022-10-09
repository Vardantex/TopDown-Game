extends "res://NPC/PlayerDetection.gd"

#Find Node: Node Name, Recursive, is it owned by this node?
onready var navigation = get_tree().get_root().find_node("Navigation", true, false)
onready var destinations = navigation.get_node("Destinations")

var motion 
var possible_destinations
var path

func _ready() -> void:
	randomize()
	possible_destinations = destinations.get_children()
	make_path()

func make_path():
	var destination = possible_destinations[randi() % possible_destinations.size() -1]
	#(current location, desired location)
	path = navigation.get_simple_path(position, destination.position)  
	print(path)
	
func _on_Timer_timeout() -> void:
	pass # Replace with function body.
