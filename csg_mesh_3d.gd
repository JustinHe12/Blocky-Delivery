extends CSGMesh3D


func _on_child_entered_tree(body):
	print(body.name)
