class_name DeadState
extends State

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.play_animation("death")
	player.set_collision_layer_value(1, false)
	player.set_collision_mask_value(1, false)

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += 1400 * delta
	player.move_and_slide()
