class_name CameraAreaConstraint
extends CameraConstraint

# Camera constraint designes to keep the camera within a certain area

var top_left : Vector2
var bottom_right : Vector2
var zoom_range : Vector2

func _init(top_left, bottom_right, zoom_range):
	self.top_left = top_left
	self.bottom_right = bottom_right
	self.zoom_range = zoom_range

func _apply_constraint(position,rotation,zoom) -> Dictionary:
	var ret_pos : Vector2 =  position
	ret_pos.x = clamp(ret_pos.x,top_left.x,bottom_right.x)
	ret_pos.y = clamp(ret_pos.y,top_left.y,bottom_right.y)
	var ret_zooom = clamp(zoom,zoom_range.x,zoom_range.y)
	return {
			"position":ret_pos,
			"zoom":ret_zooom
	}
