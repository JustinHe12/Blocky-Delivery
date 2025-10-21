extends Path3D

@export var loop = true
@export var speed = 3.0
@export var speed_scale = 1

@onready var path = $PathFollow3D
@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	if not loop:
		animation.play("moving platform")
		animation.speed_scale = speed_scale
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
