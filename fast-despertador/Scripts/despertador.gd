extends Area2D
var room: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room = get_tree().get_first_node_in_group("quarto")
	 #Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	
	if room:
		room.start.call_deferred() # Replace with function body.
