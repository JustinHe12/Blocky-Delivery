extends Area3D
@export var reset: NodePath
@onready var Reset = get_node(reset)

func _on_body_entered(body):
	print(body.name)
	
		
