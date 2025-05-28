extends Area2D

const SPEED = 800

var velocity = Vector2.ZERO
var shooter = null

func _ready():
	rotation = velocity.angle()
	connect("body_entered", self, "_on_Bullet_body_entered")

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body == shooter:
		return
	if body.has_method("kill"):
		body.kill()
	queue_free()
