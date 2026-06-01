extends CharacterBody2D
@export var speed: float = 500
var pillow: Area2D
@export var quarto: Node2D
var score = 0
var life = 100
@onready var anim = $AnimatedSprite2D
signal Morreu
var can_move = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pillow = get_tree().get_first_node_in_group("travesseiro")
	
	if pillow:
		global_position = pillow.position

func _physics_process(delta):
	if can_move:
		get_input()
		move_and_slide()
	if life <= 0:
		emit_signal("Morreu")
	if Input.is_action_just_pressed("reset"):
		if quarto:
			quarto.start()

		
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * speed
	
	update_animation(input_direction)
	


func update_animation(dir: Vector2):
	if dir == Vector2.ZERO:
		anim.stop() # ou anim.play("idle") se você tiver
		return

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim.play("right")
		else:
			anim.play("left")
	else:
		if dir.y > 0:
			anim.play("down")
		else:
			anim.play("up")
