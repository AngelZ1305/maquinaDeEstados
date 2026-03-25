class_name AttackState
extends State

const ATTACK_RANGE := 80.0
const ATTACK_DAMAGE := 20

func enter() -> void:
	player.velocity.x = 0
	player.play_animation("attack")

	_apply_damage_to_enemies()

	player.body_sprite.animation_finished.connect(_on_attack_finished)

func exit() -> void:
	if player.body_sprite.animation_finished.is_connected(_on_attack_finished):
		player.body_sprite.animation_finished.disconnect(_on_attack_finished)

func _on_attack_finished() -> void:
	player.get_node("StateMachine").transition_to("idle")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += 1400 * delta
	player.move_and_slide()

func _apply_damage_to_enemies() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")

	for enemy in enemies:
		if enemy == null:
			continue

		var distance := player.global_position.distance_to(enemy.global_position)

		if distance <= ATTACK_RANGE:
			enemy.take_damage(ATTACK_DAMAGE)
			print("Golpeaste a:", enemy.name)
