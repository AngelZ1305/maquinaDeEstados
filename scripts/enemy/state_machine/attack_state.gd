# attack_state.gd (enemigo)
class_name EnemyAttackState
extends State

const ATTACK_RANGE  := 80.0
var ATTACK_DAMAGE: Array[int] = [10, 20, 30]  # rápido, fuerte, especial

func enter() -> void:
	player.velocity.x = 0
	player.play_animation("attack")

	# Elegir ataque aleatorio
	var tipo := randi_range(0, 2)
	var damage := ATTACK_DAMAGE[tipo]

	match tipo:
		0: print("Enemigo: golpe rápido — ", damage, " daño")
		1: print("Enemigo: golpe fuerte — ", damage, " daño")
		2: print("Enemigo: ataque especial — ", damage, " daño")

	# Aplicar daño al jugador si está en rango
	var target = player.player_ref
	if target != null:
		var distance := player.global_position.distance_to(target.global_position)
		if distance <= ATTACK_RANGE:
			target.take_damage(damage)

	player.anim.animation_finished.connect(_on_attack_finished)

func exit() -> void:
	if player.anim.animation_finished.is_connected(_on_attack_finished):
		player.anim.animation_finished.disconnect(_on_attack_finished)

func _on_attack_finished() -> void:
	player.get_node("StateMachine").transition_to("cooldown")
