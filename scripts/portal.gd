

extends Area3D
var level = 1

@export var next_level = "level_1"

func _on_body_entered(body):
	
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/"+next_level+".tscn") 
		body.nextlevel(next_level)
