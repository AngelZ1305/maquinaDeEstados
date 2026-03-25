# state.gd
class_name State
extends Node

# Referencia al jugador, se asigna desde StateMachine
var player : CharacterBody2D

# Se llama al entrar al estado
func enter() -> void:
	pass

# Se llama al salir del estado
func exit() -> void:
	pass

# Lógica de input (teclas)
func handle_input(_event: InputEvent) -> void:
	pass

# Lógica por frame (animaciones, timers)
func update(_delta: float) -> void:
	pass

# Lógica de física (movimiento, colisiones)
func physics_update(_delta: float) -> void:
	pass
