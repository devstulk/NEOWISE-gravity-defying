extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var sprite_type: Array = anim.sprite_frames.get_animation_names()

var speed: float = 150.0
var first_planet: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !first_planet:
		position.x = randf_range(80.0, 297.0)
		
	anim.play(sprite_type[randi_range(0, sprite_type.size() - 1)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed * delta
	
	if position.y > 750:
		queue_free()
