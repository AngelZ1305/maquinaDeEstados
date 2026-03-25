# chase_state.gd
class_name ChaseState
extends State

const SPEED          := 160.0
const GRAVITY        := 1400.0
const ATTACK_RANGE   := 80.0

func enter() -> void:
	player.play_animation("walk")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta

	var target = player.player_ref
	print("target: ", target)

	if target == null:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.move_and_slide()
		return

	var distance := player.global_position.distance_to(target.global_position)

	if distance <= ATTACK_RANGE:
		player.get_node("StateMachine").transition_to("attack")
		return

	var direction :float= sign(target.global_position.x - player.global_position.x)
	player.velocity.x = direction * SPEED
	player.flip_sprite(direction < 0)
	player.move_and_slide()
