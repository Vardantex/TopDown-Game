extends Area2D

var can_click = false


func _ready() -> void:
	pass




func _on_Door_body_entered(body: Node) -> void:
	if body.collision_layer == 1:
		can_click == true
		open()
#	else:


func _on_Door_body_exited(body: Node) -> void:
	if body.collision_layer == 1:
		can_click = false


func _on_Door_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		open()


func open():
	$AnimationPlayer.play("Open" )

