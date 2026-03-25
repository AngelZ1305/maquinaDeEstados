# hit_state.gd (enemigo)
class_name EnemyHitState
extends State

const KNOCKBACK := 150.0
const GRAVITY   := 1400.0

func enter() -> void:
	player.play_animation("hurt")
	var direction := -1.0 if player.anim.flip_h else 1.0
	player.velocity.x = -direction * KNOCKBACK
	player.velocity.y = -150.0
	player.anim.animation_finished.connect(_on_hurt_finished)

func exit() -> void:
	if player.anim.animation_finished.is_connected(_on_hurt_finished):
		player.anim.animation_finished.disconnect(_on_hurt_finished)

func _on_hurt_finished() -> void:
	if player.hp <= 0:
		player.get_node("StateMachine").transition_to("dead")
	else:
		player.get_node("StateMachine").transition_to("chase")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta
	player.velocity.x = move_toward(player.velocity.x, 0, 600 * delta)
	player.move_and_slide()
