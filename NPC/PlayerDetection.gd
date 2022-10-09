extends "res://Characters/TemplateCharacter.gd"

const FOV_TOLERANCE = 40
const RED = Color(1,.25,.25)
const WHITE = Color(1,1,1)
const MAX_DETECTION_RANGE = 320

var Player

#every frame, get player node
func _ready() -> void:
	Player = get_node("/root").find_node("Player", true, false)



func _process(delta: float) -> void:
	if Player_in_FOV() and Player_in_LOS():
		$Torch.color = RED 
	else:
		$Torch.color = WHITE


func Player_in_FOV():
	#vector looking right by global rotation
	var npc_facing_direction = Vector2(1, 0).rotated(global_rotation)
	
	#Obtain the direction to player
	var direction_to_Player = (Player.position - global_position.normalized())

#absolute ignores if value is + or -
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false

func Player_in_LOS():
	#Draw a line for detection
	var space = get_world_2d().direct_space_state# 3rd parameter, list things to ignore
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self]
			, collision_mask)
	
	
	if not LOS_obstacle:
		return false
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	var Player_in_Range = distance_to_player < MAX_DETECTION_RANGE
	
	if LOS_obstacle.collider == Player and Player_in_Range:
		return true
	else:
		return false
