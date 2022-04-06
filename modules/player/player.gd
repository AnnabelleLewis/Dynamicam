extends KinematicBody2D

onready var camera : DynamicCamera = get_tree().get_nodes_in_group("dynamic_camera")[0]

var move_speed : int =  100

export (OpenSimplexNoise) var noise

func _ready():
	camera.add_focus_point(self)
	
	var props = {
		"power" : 5.0,
		"noise_texture" : noise,
		"power_delta" : 0.0,
		"timescale" : 10.0,
		"rotate":true,
		"rotate_scale":0.002,
	}
	var shake = SimplexShake.new(props)
	camera.add_screenshake(shake)

func _physics_process(delta):
	var move_vec = Vector2(
			int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
			int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	).normalized()
	
	move_and_slide(move_vec*move_speed)
