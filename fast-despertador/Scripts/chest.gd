extends Area2D
var player: CharacterBody2D
@export var chest: StaticBody2D
@export var can_be_collected = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") 
	# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	
	 
	if can_be_collected:
		if player:
			if body == player:
				player.score += 10
				
				can_be_collected = false

 # Replace with function body.
