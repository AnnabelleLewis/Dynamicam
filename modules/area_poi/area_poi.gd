class_name AreaPOI
extends Area2D

# Creates a temporary point of interest for the camera
#  Addts it'self to the camera's focus points for as long as the player is 
#  inside the collider.

# Gets the first object in the dynamic_camera tag, all dynamic cameras should have this tag
onready var camera : DynamicCamera = get_tree().get_nodes_in_group("dynamic_camera")[0]

func _ready():
	connect("body_entered",self,"on_player_enter")
	connect("body_exited",self,"on_player_exit")

func on_player_enter(player):
	camera.add_focus_point(self)

func on_player_exit(player):
	camera.remove_focus_point(self)
