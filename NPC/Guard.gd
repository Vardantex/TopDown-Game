extends "res://NPC/PlayerDetection.gd"

#Find Node: Node Name, Recursive, is it owned by this node?
onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

var motion 
var possible_destinations
var path = [0]

export var minimum_arrival_distance = 5 
export var walk_speed = .5

func _ready() -> void:
	randomize()
	possible_destinations = destinations.get_children()
	make_path()

func _physics_process(delta: float) -> void:
	navigate()


func navigate():
	#this var is going to the first path destination in the array
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > minimum_arrival_distance:
		move()
	else:
		update_path()

func move():
	#Look directly to where they should be going 
	look_at(path[0])
	
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	
	move_and_slide(motion)


func update_path():
	if path.size() == 1 and $Timer.is_stopped():
		$Timer.start()
	else:
		path.remove(0)

func make_path():
	var destination = possible_destinations[randi() % possible_destinations.size() -1]
	#(current location, desired location)
	path = navigation.get_simple_path(position, destination.position, false)  
	print(path)
	
	
#This function trigger when timer stops
func _on_Timer_timeout() -> void:
	make_path()
