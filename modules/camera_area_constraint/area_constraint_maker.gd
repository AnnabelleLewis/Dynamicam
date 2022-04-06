tool
class_name AreaConstraintMaker
extends ConstraintMaker

# Creates an area constraint
#  Keeps the camera in a 2d area and locks the zoom

var _constraint : CameraAreaConstraint

export (Vector2) var extent setget set_extent 
export (Vector2) var zoom_range

func _ready():
	_constraint = CameraAreaConstraint.new(
			global_position, 
			global_position+extent,
			zoom_range)

func get_constraint():
	return _constraint

func _draw():
	var draw_rect = Rect2(Vector2.ZERO,extent)
	draw_rect(draw_rect,Color(0.8,0.4,0.4,0.5))

func set_extent(new_extent):
	extent = new_extent
	update()
