

extends Area3D
var level = 1

@export var next_level = "level_1"

func _on_body_entered(body):
	
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/"+next_level+".tscn") 
		#level = level + 1
		#if level == 1:
			#get_tree().change_scene_to_file("res://scenes/level_2.tscn")
			#level = 2
			#print(level)
			#
		#elif level == 2:
			#get_tree().change_scene_to_file("res://scenes/level_3.tscn")
			#level = 3
		
