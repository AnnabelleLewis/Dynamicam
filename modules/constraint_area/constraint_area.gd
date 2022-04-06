class_name ConstraintArea
extends Area2D

# Acts as an area that applies a camera constraint on player enter
#  Applies the constraint created by the constraint_maker on player enter, and
#  removes them when the player leaves

export (NodePath) onready var constraint_maker = get_node(constraint_maker)

# Gets the first object in the dynamic_camera tag, all dynamic cameras should have this tag
onready var camera : DynamicCamera = get_tree().get_nodes_in_group("dynamic_camera")[0]

func _ready():
	connect("body_entered",self,"on_player_enter")
	connect("body_exited",self,"on_player_exit")

func on_player_enter(player):
	camera.add_constraint(constraint_maker.get_constraint())

func on_player_exit(player):
	camera.remove_constraint(constraint_maker.get_constraint())
