# cooldown_state.gd
class_name CooldownState
extends State

const GRAVITY := 1400.0

var _timer    : float = 0.0
var _duration : float = 0.0

func enter() -> void:
	player.play_animation("idle")
	player.velocity.x = 0
	_timer    = 0.0
	_duration = randf_range(3.0, 6.0)  # espera entre 3 y 6 segundos

func update(delta: float) -> void:
	_timer += delta
	if _timer >= _duration:
		player.get_node("StateMachine").transition_to("chase")

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta
	player.move_and_slide()
