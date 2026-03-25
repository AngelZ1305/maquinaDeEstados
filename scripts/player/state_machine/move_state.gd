class_name MoveState
extends State

const SPEED      := 280.0
const JUMP_FORCE := -600.0
const GRAVITY    := 1400.0

func enter() -> void:
	player.play_animation("walk")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		player.get_node("StateMachine").transition_to("attack")
	if event.is_action_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = JUMP_FORCE

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		player.velocity.x = direction * SPEED
		player.flip_sprites(direction < 0)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		if player.velocity.x == 0 and player.is_on_floor():
			player.get_node("StateMachine").transition_to("idle")

	player.move_and_slide()
