extends KinematicBody2D

const MOVE_SPEED = 300
const BULLET_SCENE = preload("res://Bullet.tscn")

onready var raycast = $RayCast2D
onready var anim = $AnimatedSprite

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)

	if move_vec != Vector2.ZERO:
		if not anim.is_playing():
			anim.play("walk")
	else:
		anim.stop()
		anim.frame = 0

	if move_vec.x != 0:
		anim.flip_h = move_vec.x < 0

	var to_mouse = get_global_mouse_position() - global_position
	raycast.rotation = to_mouse.angle()

	if Input.is_action_just_pressed("shoot"):
		var bullet = BULLET_SCENE.instance()
		bullet.global_position = global_position
		bullet.velocity = to_mouse.normalized() * 800
		bullet.shooter = self
		get_parent().add_child(bullet)

func kill():
	get_tree().reload_current_scene()
