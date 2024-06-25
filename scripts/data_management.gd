extends Node2D

var save_path: String = 'res://best_score.cfg'

# Called when the node enters the scene tree for the first time.
func _ready():
	# If not exist file create.
	if !FileAccess.file_exists('best_score.cfg'):
		var config = ConfigFile.new()
		config.save(save_path)

# Save data in file.
func _save_data(score):
	var config = ConfigFile.new()
	config.set_value('score', 'best_score', score)
	config.save(save_path)

# Load data in file.
func _load_data():
	var config = ConfigFile.new()
	var err = config.load(save_path)
	if err != OK:
		return
	
	return config.get_value('score', 'best_score', 0)
