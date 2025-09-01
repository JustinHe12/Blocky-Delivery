extends Area3D
@export var reset: NodePath
@onready var Reset = get_node(reset)

func _on_body_entered(body):
	if body.name == "Player":
		#tell the body to respawn
		body.respawn()
	
		
