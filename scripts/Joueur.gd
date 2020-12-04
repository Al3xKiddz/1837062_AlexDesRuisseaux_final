extends KinematicBody2D

signal health_updated(health)
signal killed()

onready var particule = $Particles2D
const speed = 150
var velocity = Vector2()
export (PackedScene) var balle
onready var tireur = $Position2D
onready var pew = $Pewpew
export (float) var max_health = 100
onready var health = max_health
onready var mort = $Mort

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/Interface/TextureProgress").value = health


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("droite"): 
		particule.set_emitting(true)
		velocity.y += 1
	if Input.is_action_pressed("gauche"):
		particule.set_emitting(true)
		velocity.y -= 1
	if Input.is_action_pressed("haut"):
		particule.set_emitting(true)
		velocity.x += 1
	if Input.is_action_pressed("bas"):
		particule.set_emitting(true)
		velocity.x -= 1
	if Input.is_action_just_pressed("tirer"):
		var b = balle.instance()
		b.start(tireur.global_position, rotation)
		pew.play()
		get_parent().add_child(b)
	velocity = (velocity.normalized()*speed).rotated(rotation)
func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
func _process(delta):
	var dir = get_global_mouse_position() - global_position
	var ancienne = rotation
	rotation = dir.angle()

func hit(nom):
	if "Missile" in nom:
		_set_health(health - 10)
	if "BalleEnnemis" in nom:
		_set_health(health - 5)

func kill():
	mort.play()
	Global._goto_scene("res://scenes/Mort.tscn")

func _set_health(value):
	health = value
	print(health)
	get_node("CanvasLayer/Interface/TextureProgress").value = health
	if health <= 0:
		kill()
