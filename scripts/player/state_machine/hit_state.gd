class_name HitState
extends State

const KNOCKBACK := 200.0

func enter() -> void:
	player.play_animation("hurt")
	var direction := -1.0 if player.body_sprite.flip_h else 1.0
	player.velocity.x = -direction * KNOCKBACK
	player.velocity.y = -200.0
	player.body_sprite.animation_finished.connect(_on_hurt_finished)

func exit() -> void:
	if player.body_sprite.animation_finished.is_connected(_on_hurt_finished):
		player.body_sprite.animation_finished.disconnect(_on_hurt_finished)

func _on_hurt_finished() -> void:
	if player.hp <= 0:
		player.get_node("StateMachine").transition_to("dead")
	else:
		player.get_node("StateMachine").transition_to("idle")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += 1400 * delta
	player.velocity.x = move_toward(player.velocity.x, 0, 600 * delta)
	player.move_and_slide()
