# enemy.gd
extends CharacterBody2D

const GRAVITY := 1400.0

var hp         := 80
var max_hp     := 80
var player_ref : CharacterBody2D = null

@onready var anim          : AnimatedSprite2D = $AnimatedSprite2D
@onready var detection     : Area2D           = $DetectionArea
@onready var state_machine : StateMachine     = $StateMachine

func _ready() -> void:
	detection.body_entered.connect(_on_body_entered)
	detection.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_ref = body

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_ref = null

func play_animation(anim_name: String) -> void:
	anim.play(anim_name)

func flip_sprite(flip: bool) -> void:
	anim.flip_h = flip

func take_damage(amount: int) -> void:
	if state_machine.current_state is DeadState:
		return

	hp -= amount
	hp = max(hp, 0)

	print(name, " recibió ", amount, " de daño. HP: ", hp, "/", max_hp)

	if hp <= 0:
		state_machine.transition_to("dead")
	else:
		state_machine.transition_to("hit")
