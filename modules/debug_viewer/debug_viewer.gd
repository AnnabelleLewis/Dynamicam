class_name DebugViewer
extends ColorRect

var debug_texts := {}

func _ready():
	add_to_group("debug_viewer")

func _process(delta):
	$Label.text = ""
	for i in debug_texts.keys():
		$Label.text += "%s: %s\n"%[i,debug_texts[i]]

func set_debug_text(index,text):
	debug_texts[index] = text

func remove_debug_index(index):
	debug_texts.erase(index)
