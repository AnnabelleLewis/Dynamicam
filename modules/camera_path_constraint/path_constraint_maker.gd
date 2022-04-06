class_name PathConstraintMaker
extends ConstraintMaker

# Creates an area constraint
#  Locks the camera to a path2d, must have a Path2D as the first child

var _constraint : CameraPathConstraint

export (Curve2D) var path
export (Vector2) var zoom_range

func _ready():
	path = get_child(0).curve
	_constraint = CameraPathConstraint.new(
			path, 
			zoom_range)

func get_constraint():
	return _constraint
