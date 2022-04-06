class_name SimplexShake
extends CameraShake

# Shakes the camera using a SimplexNoiseTexture

var time : float # The ammount of time the shake has been active
var timescale : float # How fast the time rises
var power : float # The shake magnatude
var power_delta : float # How much the shake changes per second
var power_min : float # The minimum power
var power_max : float # The maximum power
var noise_texture : OpenSimplexNoise
var rotate : bool # Should this do camera rotation
var rotate_scale : float # Multiplier for rotation

func _init(props:Dictionary):
	time = float(OS.get_ticks_msec())
	power = props.power
	noise_texture = props.noise_texture
	
	if props.has("power_delta"):
		power_delta = props.power_delta
	else:
		power_delta = -1.0
		
	if props.has("timescale"):
		timescale = props.timescale
	else:
		timescale = 1.0
		
	if props.has("power_min"):
		power_min = props.power_min
	else:
		power_min = 0.0
		
	if props.has("power_max"):
		power_max = props.power_max
	else:
		power_max = 100000000.0
	
	if props.has("rotate"):
		rotate = props.rotate
	else:
		rotate = false
	
	if props.has("rotate_scale"):
		rotate_scale = props.rotate_scale
	else:
		rotate_scale = 1.0

#   Takes in the camera position and rotation, and returns a vector3 containing 
# the shake offset as the x and y variables and the rotation as the z variable
func _apply_shake(delta) -> Vector3:
	time += delta * timescale
	power += delta * power_delta 
	power = clamp(power, power_min, power_max)
	
	var shake_volume := power * power
	
	var base_shake := Vector3(
			noise_texture.get_noise_3d(time,0,0),
			noise_texture.get_noise_3d(0,time,0),
			noise_texture.get_noise_3d(0,time,0) * rotate_scale if rotate else 0.0
	)
	
	print_debug(base_shake * shake_volume)
	
	return base_shake * shake_volume
