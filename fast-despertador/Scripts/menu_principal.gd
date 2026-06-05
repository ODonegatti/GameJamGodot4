extends Control

@onready var play_button = $VBoxContainer/Jogar
@onready var options_button = $VBoxContainer/Configuracoes
@onready var quit_button = $VBoxContainer/Sair

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Cenas/main.tscn")

func _on_options_pressed():
	print("Abrir menu de configurações (ainda não implementado)")
	
func _on_quit_pressed():
	get_tree().quit()
