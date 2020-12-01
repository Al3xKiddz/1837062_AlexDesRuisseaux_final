extends Node
var current_scene =null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)

func _goto_scene(path):
	call_deferred("_defered_goto_scene",path)

func _defered_goto_scene(path):
	current_scene.free()
	var new_scene = ResourceLoader.load(path)
	current_scene  = new_scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

