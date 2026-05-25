extends CharacterBody2D
@export var speed = 1000
var bed: Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim = $AnimatedSprite2D
	anim.play("default") 
	bed = get_tree().get_first_node_in_group("cama")
	if bed:
		global_position = bed.position# Replace with function body.

func _physics_process(delta):
	get_input()
	move_and_slide()
		
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
