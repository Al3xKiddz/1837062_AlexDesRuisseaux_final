extends KinematicBody2D


var speed = 500 
var velo = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start(pos, dir):
	rotation = dir
	position = pos
	velo = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velo*delta)
	if collision:
		if collision.collider.has_method("hit"):
			print(self.name)
			collision.collider.hit(self.name)
			_on_VisibilityNotifier2D_screen_exited()
		velo = velo.bounce(collision.normal)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
