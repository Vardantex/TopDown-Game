extends Template_Character

var motion = Vector2()

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	update_movement()
	move_and_slide(motion)
	
	

func update_movement():
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("WASD_DOWN") and not Input.is_action_pressed("WASD_UP"):
		#Use the clamp tool (vector, min value, max value)
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("WASD_UP") and not Input.is_action_pressed("WASD_DOWN"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	else: 
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("WASD_LEFT") and not Input.is_action_pressed("WASD_RIGHT"):
		#Use the clamp tool (vector, min value, max value)
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	elif Input.is_action_pressed("WASD_RIGHT") and not Input.is_action_pressed("WASD_LEFT"):
		motion.x = clamp(motion.x + SPEED,  MAX_SPEED, 0)
	else: 
		motion.x = lerp(motion.x, 0, FRICTION)
	
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Light_Toggle"):
		#This says: whatever you are not, become
		$Torch.enabled = !$Torch.enabled
