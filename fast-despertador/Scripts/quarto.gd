extends Node2D

# Tamanho do grid
var grid_width = 9
var grid_height = 5
var cell_size = 128
var plays = 0

# Cena do objeto que será instanciado
#@export var object_scene: PackedScene
@export var wardrobe: PackedScene
@export var ball: PackedScene
@export var chest: PackedScene
@export var puff: PackedScene
@export var mimic: PackedScene

@export var bed: PackedScene
@export var alarm: PackedScene
@export var pillow: Area2D

@export var score: Label

var player: CharacterBody2D
var objetos: Array[StaticBody2D]= []
var enemies: Array[CharacterBody2D]



func _physics_process(delta: float) -> void:
	if player:
		var pontuacao = player.score
	
		score.text = str(pontuacao)

func _ready():
	
	player = get_tree().get_first_node_in_group("player")
	
	if player:
		start()
	
	
		
func start():
	var positions = []
	plays += 1
	
	player.global_position = pillow.global_position
	
	clear_entities()

	# Gera todas as posições possíveis no grid
	for x in range(grid_width):
		for y in range(grid_height):
			positions.append(Vector2(x, y))
			
	#Gerador de rota simples
	var caminho = []
	var posicao = Vector2(1, 0)
	
	
	while true :
		caminho.append(Vector2(posicao))
		if posicao.x == 8 and posicao.y == 4 :
			break
		
		var escolha = randi() % 2
		
		if posicao.x == 8 or escolha :
			posicao.y += 1
		elif posicao.y == 4 or not escolha or posicao.x == 0 :
			posicao.x += 1
		posicao.x = clamp(posicao.x, 0, 8)
		posicao.y = clamp(posicao.y, 0, 4)
	
	# Instancia objetos em posições aleatórias
	for pos in positions:
		
		if pos == Vector2(0, 0) and plays <= 1:
			var obj3 = pillow
			obj3.global_position = Vector2(64, 64)
			#add_child(obj3)
		
		elif pos == Vector2(8, 4) and plays <= 1:
			var obj2 = alarm.instantiate()
			obj2.position = pos * cell_size
			add_child(obj2)
			
		
		elif pos == Vector2(0, 1) and plays <= 1:
			var obj1 = bed.instantiate()
			obj1.position = pos * cell_size
			add_child(obj1)
			
			
		elif pos in caminho or pos == Vector2(1, 0) or pos == Vector2(1, 1):
			pass
			
		elif pos == Vector2(0, 0) or pos == Vector2(0,1):
			pass
			
		else:
			var intRng = randi() % 10
			if intRng in [0, 1, 2]:
				pass
			
			elif intRng in [3, 4]:
				var obj4 = wardrobe.instantiate()
				obj4.position = pos * cell_size
				add_child(obj4)
				objetos.append(obj4)
			
			elif intRng in [5, 6]:
				var obj4 = ball.instantiate()
				obj4.position = pos * cell_size
				add_child(obj4)
				objetos.append(obj4)
				
			elif intRng == 7:
				var obj4 = chest.instantiate()
				obj4.position = pos * cell_size
				add_child(obj4)
				objetos.append(obj4)
				
			elif intRng == 8 and pos != Vector2(0, 1):
				var obj4 = mimic.instantiate()
				obj4.position = pos * cell_size
				add_child(obj4)
				enemies.append(obj4)
			
			elif intRng == 9:
				var obj4 = puff.instantiate()
				obj4.position = pos * cell_size
				add_child(obj4)	
				objetos.append(obj4)		 
	
func clear_entities():
	
	
	var quantidade_objetos = 0
	for i in objetos:
		quantidade_objetos += 1
		
	for i in range(quantidade_objetos):
		objetos[i].queue_free()
	objetos.clear()
	
	var quantidade_enemies = 0
	for i in enemies:
		quantidade_enemies += 1
	
	for i in range(quantidade_enemies):
		enemies[i].queue_free()
	enemies.clear()
