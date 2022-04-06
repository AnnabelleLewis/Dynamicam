class_name CollisionPolygonBuilder
extends StaticBody2D

func _ready():
	add_child(CollisionPolygon2D.new())
	get_child(0).polygon = get_parent().polygon
	get_child(0).build_mode = 1
