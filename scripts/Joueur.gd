extends KinematicBody2D
const speed = 120
var velocity = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("droite"): 
		velocity.x += 1
	if Input.is_action_pressed("gauche"):
		velocity.x -= 1
	if Input.is_action_pressed("haut"):
		velocity.y -= 1
	if Input.is_action_pressed("bas"):
		velocity.y += 1
	velocity = velocity.normalized()*speed
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
#func _process(delta):
	#if Helth.helth == 2:
	#	current_frame = 0
	#elif Helth.helth == 1:
	#	current_frame = 1
	#elif Helth.helth == 0:
	#	current_frame = 2
	#	yield(get_tree().create_timer(0.5),"timeout")
	#	Global._goto_scene("res://scenes/Died.tscn")
	#coeursderockeurs.frame = current_frame
