# hud.gd completo
extends CanvasLayer

@onready var player_bar     : ProgressBar = $PlayerHUD/PlayerVBox/PlayerHealthBar
@onready var enemy_bar      : ProgressBar = $EnemyHUD/EnemyVBox/EnemyHealthBar
@onready var game_over      : Control     = $GameOverScreen
@onready var result_label   : Label       = $GameOverScreen/VBoxContainer/ResultLabel
@onready var restart_button : Button      = $GameOverScreen/VBoxContainer/RestartButton
@onready var quit_button : Button = $GameOverScreen/VBoxContainer/QuitButton


var player_ref : CharacterBody2D = null
var enemy_ref  : CharacterBody2D = null
var game_ended : bool = false

func _ready() -> void:
	await owner.ready

	
	player_ref = get_parent().get_node_or_null("World/Player")
	enemy_ref  = get_parent().get_node_or_null("World/Enemy")
	
	restart_button.pressed.connect(_on_restart)
	quit_button.pressed.connect(_on_quit)

func _on_quit() -> void:
	get_tree().quit()
	
func _process(_delta: float) -> void:
	print("HUD process corriendo")
	if game_ended:
		return

	if player_ref:
		player_bar.value = player_ref.hp

	if enemy_ref and is_instance_valid(enemy_ref):
		enemy_bar.value = enemy_ref.hp
	else:
		enemy_bar.value = 0

	_check_game_over()

func _check_game_over() -> void:
	if player_ref:
		print("HP Jugador: ", player_ref.hp)
	
	if is_instance_valid(enemy_ref):
		print("HP Enemigo: ", enemy_ref.hp)
	else:
		print("Enemigo ya no existe en escena")

	# Jugador muere
	if player_ref and player_ref.hp <= 0:
		print("Condición de derrota cumplida")
		_show_game_over("derrota")

	# Enemigo muere
	if not is_instance_valid(enemy_ref) or (enemy_ref and enemy_ref.hp <= 0):
		print("Condición de victoria cumplida")
		_show_game_over("victoria")

func _show_game_over(result: String) -> void:
	game_ended = true
	game_over.visible = true

	if result == "victoria":
		result_label.text = "You win"
		result_label.add_theme_color_override("font_color", Color("#2ecc71"))
	else:
		result_label.text = "Game Over"
		result_label.add_theme_color_override("font_color", Color("#e74c3c"))

func _on_restart() -> void:
	get_tree().reload_current_scene()
