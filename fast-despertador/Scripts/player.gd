extends CharacterBody2D
@export var speed = 500
var pillow: Area2D
@export var quarto: Node2D
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $AnimatedSprite2D
	pillow = get_tree().get_first_node_in_group("travesseiro")

	if pillow:
		global_position = pillow.position

func _physics_process(delta):
	get_input()
	move_and_slide()
		
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("reset"):
		if quarto:
			quarto.start()
