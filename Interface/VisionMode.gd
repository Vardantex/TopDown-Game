extends CanvasModulate

const DARK = Color("5c4a4a")
const NIGHTVISION = Color("0b9784")
var cooldown = false

func _ready() -> void:
	color = DARK
	visible = true
	
	

#Use the connected method in the Interface group
func cycle_vision_mode():
	if not cooldown:
		if color == NIGHTVISION:
			DARK_mode()
		else:
			NIGHTVISION_mode()
		cooldown = true
		$Timer.start()
		
func DARK_mode():
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()

func NIGHTVISION_mode():
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()


func _on_Timer_timeout() -> void:
	cooldown = false
