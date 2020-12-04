extends Node
var current_scene =null
var nbennemis = 8

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)
	nbennemis = 8

func _goto_scene(path):
	call_deferred("_defered_goto_scene",path)

func ennemi_mort():
	nbennemis -= 1
	if nbennemis == 0:
		if current_scene.name == "Main":
			_goto_scene("res://scenes/Lvl2.tscn")
			nbennemis = 8
		if current_scene.name == "Lvl2":
			_goto_scene("res://scenes/Lvl3.tscn")
			nbennemis = 8
		if current_scene.name == "Lvl3":
			_goto_scene("res://scenes/Gagnant.tscn")
			nbennemis = 8
	

func _defered_goto_scene(path):
	current_scene.free()
	var new_scene = ResourceLoader.load(path)
	current_scene  = new_scene.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

