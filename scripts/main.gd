extends Control

@onready var spawn_timer = $SpawnTimer
@onready var player = $player
@onready var menu = $Menu
@onready var score_label = $ScoreLabel
@onready var score_timer = $ScoreTimer
@onready var sound = $AudioStreamPlayer2D

const PLANET = preload("res://scenes/planet.tscn")

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Instantieate new planets.
func _on_spawn_timer_timeout():
	var planet = PLANET.instantiate()
	add_child(planet)


# Star game.
func _on_menu_new_game_pressed():
	score = 0
	_update_score_label(score)
	# Instantiate first planet
	var planet = PLANET.instantiate()
	planet.position.x = get_viewport_rect().size.x / 2
	planet.first_planet = true
	add_child(planet)
	
	# Enable player moviments.
	player.game_stated = true
	
	# Start timers.
	spawn_timer.start()
	score_timer.start()
	

# Game over player die.
func _on_player_game_over():
	# Stop timers.
	spawn_timer.stop()
	score_timer.stop()
	
	# Check if has a new best score.
	var new_best_score = _check_new_best_score(score)

	# Remove if exist planet on screen.
	var planets = get_tree().get_nodes_in_group('planet')
	for planet in planets:
		planet.queue_free()
	
	# Show screen game over.
	menu._show_game_over(score, new_best_score)


# Check new best score.
func _check_new_best_score(current_score: int):
	var new_best_score: bool = false
	
	var best_score = DataManagement._load_data()
	if current_score > best_score:
		DataManagement._save_data(current_score)
		new_best_score = true
		
	return new_best_score


# Incress score.
func _on_score_timer_timeout():
	score += 1
	_update_score_label(score)


# Update score label.
func _update_score_label(score: int):
	score_label.text = str(score)


# Enable or disable sound.
func _on_menu_sound_toggle(anim: AnimatedSprite2D):
	if sound.playing:
		anim.play('sound_disabled')
		sound.stop()
	else:
		anim.play('sound_enabled')
		sound.play()


# Sound loop.
func _on_audio_stream_player_2d_finished():
	sound.play()
