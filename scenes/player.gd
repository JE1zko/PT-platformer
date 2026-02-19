extends CharacterBody2D

@export_group("Movement")
@export var SPEED := 200.0
@export var JUMP_VELOCITY := -300.0
@export var MAX_JUMP := 2
@export var WALL_SLIDE_SPEED := 50.0

@export_group("World Bounds")
@export var LIMIT_ATAS := -100.0  
@export var LIMIT_BAWAH := 650.0

@onready var as2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var last_checkpoint_pos: Vector2 = global_position

var jump_count := 0
var is_touching_wall := false

# gravitasi
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0
		is_touching_wall = false

# movement horizontal
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

# interaksi karakter dinding
	if is_on_wall() and not is_on_floor() and velocity.y > 0:
		velocity.y = min(velocity.y, WALL_SLIDE_SPEED)
		if not is_touching_wall:
			jump_count = 0
			is_touching_wall = true
	elif not is_on_wall():
		is_touching_wall = false

# jumlah max jump di tembok
	if Input.is_action_just_pressed("move_up") and jump_count < MAX_JUMP:
		if is_on_wall() and not is_on_floor():
			velocity.y = JUMP_VELOCITY
			velocity.x = get_wall_normal().x * SPEED
		else:
			velocity.y = JUMP_VELOCITY
		
		jump_count += 1

	move_and_slide()

	_update_animation(direction)
	_check_world_bounds()

func _check_world_bounds() -> void:
	if global_position.y > LIMIT_BAWAH or global_position.y < LIMIT_ATAS:
		mati_dan_respawn()

# menentukan titik respawn
func mati_dan_respawn() -> void:
	global_position = last_checkpoint_pos
	velocity = Vector2.ZERO
	jump_count = 0
	print("Player Respawn!")

func _update_animation(direction: float) -> void:
	if direction != 0:
		as2d.flip_h = direction < 0

	if is_on_wall() and not is_on_floor():
		as2d.play("wall_jump")
		as2d.flip_h = get_wall_normal().x > 0
		return

	if not is_on_floor():
		if velocity.y < 0:
			as2d.play("double_jump" if jump_count >= 2 else "jump")
		else:
			as2d.play("fall")
		return

	if direction != 0:
		as2d.play("run")
	else:
		as2d.play("idle")
