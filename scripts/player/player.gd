# player.gd
extends CharacterBody2D

var hp     := 100
var max_hp := 100

@onready var body_sprite : AnimatedSprite2D = $BodySprite
@onready var hair_sprite : AnimatedSprite2D = $HairSprite

func _ready() -> void:
	# Sincroniza el pelo con el cuerpo siempre
	body_sprite.frame_changed.connect(_sync_hair)

func _sync_hair() -> void:
	hair_sprite.animation = body_sprite.animation
	hair_sprite.frame     = body_sprite.frame

func play_animation(anim_name: String) -> void:
	body_sprite.play(anim_name)

func flip_sprites(flip: bool) -> void:
	body_sprite.flip_h = flip
	hair_sprite.flip_h = flip

func take_damage(amount: int) -> void:
	if $StateMachine.current_state is DeadState:
		return
	hp -= amount
	hp  = max(hp, 0)
	$StateMachine.transition_to("hit")
