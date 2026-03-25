# dead_state.gd (enemigo)
class_name EnemyDeadState
extends State

const GRAVITY := 1400.0

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.play_animation("death")
	player.set_collision_layer_value(1, false)
	player.set_collision_mask_value(1, false)
	player.anim.animation_finished.connect(_on_death_finished)

func _on_death_finished() -> void:
	player.queue_free()

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta
	player.move_and_slide()
