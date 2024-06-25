extends CharacterBody2D

signal game_over

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED: float = 100.0
const JUMP_VELOCITY: float = -600.0
const GRAVITY: float = 500.0

var screen_size: Vector2
var game_stated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !game_stated:
		return
		
	# Player movements.
	_player_move(delta)
	
	# Allows the character to pass through the wall in the X axis.
	_player_pass_on_x_axis()
	
	# Game over.
	_game_over()

# Player movements.
func _player_move(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		anim.play("move")
		velocity.x = direction * SPEED
		anim.flip_h = false if direction == 1 else true
	else:
		anim.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Move player.
	move_and_slide()


# Allows the character to pass through the wall in the X axis.
func _player_pass_on_x_axis():
	if position.x > screen_size.x:
		position.x = 0
	elif position.x < 0:
		position.x = screen_size.x


# Game over.
func _game_over():
	if position.y > screen_size.y + 50:
		game_stated = false
		position = Vector2(192.0, -200.0)
		game_over.emit()
