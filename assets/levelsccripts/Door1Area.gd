extends Area2D

export (NodePath) onready var animator = get_node(animator)

func _ready():
	connect("body_entered",self,"player_enter")

func player_enter(player):
	print_debug("player_entered")
	animator.play("close")
