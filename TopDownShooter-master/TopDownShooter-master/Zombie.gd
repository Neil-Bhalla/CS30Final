extends KinematicBody2D

const MOVE_SPEED = 200

onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite

var player = null

func _ready():
	add_to_group("zombies")

func _physics_process(delta):
	if player == null:
		return

	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	move_and_collide(vec_to_player * MOVE_SPEED * delta)

	raycast.rotation = vec_to_player.angle()

	if not anim.is_playing():
		anim.play("walk")

	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll.name == "Player":
			coll.kill()

func kill():
	queue_free()

func set_player(p):
	player = p
