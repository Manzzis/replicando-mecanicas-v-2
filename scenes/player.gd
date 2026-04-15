extends CharacterBody2D

@export_category("stats")
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.
@export var extra_jump := 1
var max_jumps = 1
@export var dash_speed : float = 700.0

@onready var animation_player = $AnimationPlayer
@onready var sprite2d = $Sprite2D

var puede_dashear : bool = true
var dash_active : bool = false

var new_dir :Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	dashing()
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			extra_jump = max_jumps
		elif extra_jump > 0:
			velocity.y = JUMP_VELOCITY
			extra_jump -= 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	velocity += new_dir
	new_dir = Vector2.ZERO
	
	if Input.is_action_just_pressed("Dash") and puede_dashear:
		dash_active = true
		puede_dashear = false
		$TimeDash.start()
		$TimeNewDash.start()
	
	animation(direction)
	move_and_slide()
	
	if direction == 1:
		sprite2d.flip_h = false
	elif direction == -1:
		sprite2d.flip_h = true


func animation(direction):
	if dash_active == true:
		animation_player.play("dash_roll")
		return
	
	if is_on_floor():
		if direction == 0 and dash_active == false:
			animation_player.play("idle")
		else:
			animation_player.play("run")
	else:
		if velocity.y < 0:
			animation_player.play("jump")
		elif velocity.y > 0:
			animation_player.play("fall")
	


func dashing():
	if dash_active == true:
		SPEED = dash_speed
	if dash_active == false:
		SPEED = 300


func _on_time_dash_timeout() -> void:
	dash_active = false
	animation_player.play("idle")


func _on_time_new_dash_timeout() -> void:
	puede_dashear =  true
