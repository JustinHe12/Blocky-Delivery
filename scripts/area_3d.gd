extends Area3D
@export var save: NodePath
@onready var Save = get_node(save)

func _on_body_entered(body):
	var post = body.position
	print(post)
	if body.name == "Player":
		body.NEW(post)
	
	
	pass # Replace with function body.
