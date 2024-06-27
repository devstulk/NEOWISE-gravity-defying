extends Node2D

const password: String = '1J3HRTFUI6O0';
var file_path: String = 'user://save.dat'

# Save data in file.
func _save_data(score):
	var file = FileAccess.open_encrypted_with_pass(file_path, FileAccess.WRITE, password)
	if file == null:
		printerr('Error code: %d when try open file: %s' % [FileAccess.get_open_error(), file_path])
		print(FileAccess.get_open_error())
		return
	
	var data = {
		'best_score': score,
	}
	
	var json = JSON.stringify(data, '\t')
	file.store_string(json)
	file.close()

# Load data in file.
func _load_data():
	var file = FileAccess.open_encrypted_with_pass(file_path, FileAccess.READ, password)
	if file == null:
		return 0 # Rtruen 0 because non-exist best score.
		file.close()
	
	var content = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(content)
	if data == null:
		printerr('Cannot parse as a json: (%s)' % [file_path, content])
		return
	
	return data['best_score'] # return best score.
	
