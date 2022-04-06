class_name OccluderPolygonBuilder
extends LightOccluder2D


func _ready():
	occluder = OccluderPolygon2D.new()
	occluder.polygon = get_parent().polygon
