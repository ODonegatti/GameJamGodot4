extends Node2D
 
# Tamanho do grid
var grid_width = 9
var grid_height = 5
var cell_size = 128
var plays = 0
var mimics = 0
 
var positions_bed_pillow = [[Vector2(0,0),Vector2(0,1)],
[Vector2(0,1), Vector2(0,2)],
[Vector2(0,2), Vector2(0,3)],
[Vector2(0,3), Vector2(0,4)],
[Vector2(8,0), Vector2(8,1)],
[Vector2(8,1), Vector2(8,2)],
[Vector2(8,2), Vector2(8,3)],
[Vector2(8,3), Vector2(8,4)]]
var positions_alarm = [Vector2(0,0), 
Vector2(0,1), 
Vector2(0,2),
Vector2(0,3),
Vector2(0,4),
Vector2(8,0),
Vector2(8,1),
Vector2(8,2),
Vector2(8,3),
Vector2(8,4)]
 
# Cena do objeto que será instanciado
#@export var object_scene: PackedScene
@export var wardrobe: PackedScene
@export var ball: PackedScene
@export var chest: PackedScene
@export var puff: PackedScene
@export var mimic: PackedScene
@export var mimic_jumpscare: PackedScene
 
@export var bed: PackedScene
@export var alarm: Area2D
@export var pillow: Area2D
 
@export var score: Label
 
var player: CharacterBody2D
var objetos: Array[StaticBody2D]= []
var enemies: Array[CharacterBody2D] = []
var jumpscares: Array[Sprite2D]


 
 
 
func _physics_process(delta: float) -> void:
	if player:
		var pontuacao = player.score
		score.text = str(pontuacao)
 
func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player:
		start()
		player.connect("Morreu", Callable(self, "_on_player_morreu"))
		
	
	

func start():
	var positions = []
	plays += 1
	player.can_move = true
	player.life = 100
	
	clear_entities()
	var position_bed = randi() % 8
	var position_alarm = randi() % 10
	while(position_alarm == position_bed):
		position_alarm = randi() % 10

 
	# Gera todas as posições possíveis no grid
	for x in range(grid_width):
		for y in range(grid_height):
			positions.append(Vector2(x, y))
	#Gerador de rota simples
	var caminho = []
	var posicao
	if position_bed < 4:
		posicao = positions_bed_pillow[position_bed][0] + Vector2(1, 0)
	else:
		posicao = positions_bed_pillow[position_bed][0] - Vector2(1, 0)

	while true :
		caminho.append(Vector2(posicao))
		if posicao == positions_alarm[position_alarm]:
			break
		var direcoes = []
 
# Direções que aproximam do objetivo
		if posicao.x < positions_alarm[position_alarm].x:
			direcoes.append(Vector2.RIGHT)
 
		elif posicao.x > positions_alarm[position_alarm].x:
			direcoes.append(Vector2.LEFT)
 
		if posicao.y < positions_alarm[position_alarm].y:
			direcoes.append(Vector2.DOWN)
 
		elif posicao.y > positions_alarm[position_alarm].y:
			direcoes.append(Vector2.UP)
 
# Chance de adicionar desvios
		if randi() % 100 < 30:
			direcoes.append(Vector2.LEFT)
			direcoes.append(Vector2.RIGHT)
			direcoes.append(Vector2.UP)
			direcoes.append(Vector2.DOWN)
 
# Escolhe uma direção aleatória
		var tentativa = posicao + direcoes[randi() % direcoes.size()]
 
# Mantém dentro do grid
		tentativa.x = clamp(tentativa.x, 0, 8)
		tentativa.y = clamp(tentativa.y, 0, 4)
 
		posicao = tentativa
	# Instancia objetos em posições aleatórias
	# Posições da cama e despertador
	var pos_bed = positions_bed_pillow[position_bed][1]
	var pos_pillow = positions_bed_pillow[position_bed][0]
	var pos_alarm = positions_alarm
 
# Instancia cama
	var obj_bed = bed.instantiate()
	#var obj_pillow = pillow.instantiate()
	obj_bed.position = pos_bed * cell_size
	pillow.position = pos_pillow * cell_size
	add_child(obj_bed)
	objetos.append(obj_bed)
	
	player.global_position = pillow.global_position
	
 
# Instancia despertador
	#var obj_alarm = alarm.instantiate()
	alarm.position = pos_alarm[position_alarm] * cell_size

 
# Posiciona player/travesseiro
	#player.global_position = pos_bed * cell_size
 
# Gera objetos do mapa
	for pos in positions:
 
	# Não gera nada no caminho
		if pos in caminho:
			continue
 
	# Não gera em cima da cama
		if pos == pos_bed:
			continue
 
	# Não gera em cima do despertador
		if pos == pos_alarm[position_alarm]:
			continue
			
		if pos == pos_pillow:
			continue
 
		var intRng = randi() % 10
 
		if intRng in [0, 1, 2]:
			pass
 
		elif intRng in [3, 4]:
			var obj = wardrobe.instantiate()
			obj.position = pos * cell_size
			add_child(obj)
			objetos.append(obj)
 
		elif intRng in [5, 6]:
			var obj = ball.instantiate()
			obj.position = pos * cell_size
			add_child(obj)
			objetos.append(obj)
 
		elif intRng == 7:
			var obj = chest.instantiate()
			obj.position = pos * cell_size
			add_child(obj)
			objetos.append(obj)
 
		elif intRng == 8:
			var obj = mimic.instantiate()
			obj.position = pos * cell_size
			add_child(obj)
			enemies.append(obj)
 
		elif intRng == 9:
			var obj = puff.instantiate()
			obj.position = pos * cell_size
			add_child(obj)
			objetos.append(obj)		
			

func clear_entities():

	var quantidade_objetos = 0
	for i in objetos:
		quantidade_objetos += 1
	for i in range(quantidade_objetos):
		objetos[i].queue_free()
	objetos.clear()
	var quantidade_enemies = 0
	var quantidade_jumpscares = 0
	for i in enemies:
		quantidade_enemies += 1
	for i in range(quantidade_enemies):
		enemies[i].queue_free()
	enemies.clear()
	for i in jumpscares:
		quantidade_jumpscares +=1
		
	for i in range(quantidade_jumpscares):
		jumpscares[i].queue_free()
		mimics -= 1
	jumpscares.clear()
	
	
func _on_player_morreu():
	if mimics < 1:
		var jumpscare = mimic_jumpscare.instantiate()
		add_child(jumpscare)
		print("criou um mimic")
		mimics += 1
		jumpscare.global_position = get_viewport().get_visible_rect().size / 2
		player.can_move = false
		jumpscares.append(jumpscare)
	
