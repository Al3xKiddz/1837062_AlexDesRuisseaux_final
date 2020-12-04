extends KinematicBody2D

onready var particule = $Particles2D
const speed = 120
var velocity = Vector2()
export (PackedScene) var balle
onready var pew = $Pewpew
onready var obj = get_parent().get_node("Joueur")
var is_entered = false
var timer = null
var delai_de_balle = 5
var peut_tirer = true
onready var tireur = $Position2D
onready var tireur2
onready var tireur3
onready var mort = $Mort

# Called when the node enters the scene tree for the first time.
func _ready():
	if "Gros" in self.name:
		tireur2 = get_node("Position2D2")
		tireur3 = get_node("Position2D3")
		print(tireur2)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(delai_de_balle)
	timer.connect("timeout", self, "fini")
	add_child(timer)

func fini():
	peut_tirer = true

func _physics_process(delta):
	if is_entered:
		var dir = (obj.global_position - global_position).normalized()
		rotation = dir.angle()
		velocity = Vector2(speed,0).rotated(rotation)
		particule.set_emitting(true)
		velocity = velocity.normalized()*speed
		move_and_slide(velocity)
		if peut_tirer:
			tirer()

func tirer():
	var b = balle.instance()
	b.start(tireur.global_position, rotation)
	pew.play()
	get_parent().add_child(b)
	if "Gros" in self.name:
		print(tireur2)
		print(tireur3)
		var b2 = balle.instance()
		print(rotation)
		print(rotation_degrees)
		b2.start(tireur2.global_position, rotation -0.2)
		get_parent().add_child(b2)
		var b3 = balle.instance()
		b3.start(tireur3.global_position, rotation + 0.2)
		get_parent().add_child(b3)
	peut_tirer = false
	timer.start()

func _on_Area2D_body_entered(body):
	if body.name == "Joueur":
		is_entered = true
func _on_Area2D_body_exited(body):
	if body.name == "Joueur":
		is_entered = false

func hit(nom):
	if "Joueur" in nom:
		print("senser mourrir")
		mort.play()
		Global.ennemi_mort()
		queue_free()
