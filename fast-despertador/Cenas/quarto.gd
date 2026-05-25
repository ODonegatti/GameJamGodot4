extends Node2D

# Tamanho do grid
var grid_width = 10
var grid_height = 10
var cell_size = 64

# Cena do objeto que será instanciado
@export var object_scene: PackedScene

func _ready():
	var positions = []

	# Gera todas as posições possíveis no grid
	for x in range(grid_width):
		for y in range(grid_height):
			positions.append(Vector2(x, y))

	# Embaralha as posições
	positions.shuffle()

	# Instancia objetos em posições aleatórias
	for pos in positions:
		var obj = object_scene.instantiate()
		obj.position = pos * cell_size
		add_child(obj)
