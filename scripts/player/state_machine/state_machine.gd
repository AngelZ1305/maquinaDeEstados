# state_machine.gd
class_name StateMachine
extends Node

# --- Variables declaradas TODAS arriba ---
var current_state : State
var states        : Dictionary = {}

@onready var player      : CharacterBody2D = get_parent()
@onready var _debug_label : Label          = get_parent().get_node_or_null("DebugLabel")

func _ready() -> void:
	await owner.ready

	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player

	print("Estados registrados: ", states.keys())
	_change_state("idle")

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func transition_to(state_name: String) -> void:
	_change_state(state_name.to_lower())

func _change_state(state_name: String) -> void:
	print("Intentando cambiar a estado: ", state_name)
	if not states.has(state_name):
		push_error("Estado no encontrado: " + state_name)
		return

	if current_state:
		current_state.exit()

	current_state = states[state_name]
	current_state.enter()
	
	print("_debug_label vale: ", _debug_label)

	if _debug_label:
		_debug_label.text = state_name.capitalize()
		print("Label actualizado a: ", state_name.capitalize())
	else:
		print("ERROR: _debug_label es null")
