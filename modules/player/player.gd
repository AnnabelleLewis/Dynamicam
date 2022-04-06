extends KinematicBody2D

onready var camera : DynamicCamera = get_tree().get_nodes_in_group("dynamic_camera")[0]

var move_speed : int =  100


export (OpenSimplexNoise) var noise
export (OpenSimplexNoise) var shake_noise
func _ready():
	camera.add_focus_point(self)
	
	var props = {
		"power" : 1.0,
		"noise_texture" : noise,
		"power_delta" : 0.0,
		"timescale" : 10.0,
		"rotate":true,
		"rotate_scale":0.002,
		"shake_scale":32.0
	}
	var shake = SimplexShake.new(props)
	camera.add_screenshake(shake)

func _physics_process(delta):
	var move_vec = Vector2(
			int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
			int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	).normalized()
	
	move_and_slide(move_vec*move_speed)

func screenshake_impulse():
	var props = {
		"power" : 1.0,
		"noise_texture" : shake_noise,
		"power_delta" : -0.8,
		"timescale" : 50.0,
		"rotate":true,
		"rotate_scale":0.01,
		"shake_scale":64.0
	}
	var shake = SimplexShake.new(props)
	camera.add_screenshake(shake)
