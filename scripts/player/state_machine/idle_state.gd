class_name IdleState
extends State

func enter() -> void:
	player.velocity.x = 0
	player.play_animation("idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		player.get_node("StateMachine").transition_to("attack")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += 1400 * delta
	else:
		player.velocity.y = 0

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		player.get_node("StateMachine").transition_to("move")

	player.move_and_slide()
