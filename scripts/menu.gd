extends Control

signal new_game_pressed
signal sound_toggle

@onready var title: BoxContainer = $BoxContainerTitle
@onready var sub_title: BoxContainer = $BoxContainerSubTitle
@onready var menu_actions: BoxContainer = $BoxContainerCenter
@onready var credits: RichTextLabel = $RichTextLabelCredits
@onready var v_box_container_actions = $BoxContainerCenter/VBoxContainerActions
@onready var v_box_container_game_over = $BoxContainerCenter/VBoxContainerGameOver
@onready var box_container_bottom = $BoxContainerBottom
@onready var best_score_label = $BestScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	credits.hide()
	v_box_container_game_over.hide()
	best_score_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# Redirect to navigator when click on a credit link.
func _on_rich_text_label_credits_meta_clicked(meta):
	OS.shell_open(str(meta))


# Show credits.
func _on_credits_pressed():
	title.hide()
	sub_title.hide()
	menu_actions.hide()
	credits.show()


# Close credits and back to menu.
func _on_back_to_menu_credits_pressed():
	title.show()
	sub_title.show()
	menu_actions.show()
	credits.hide()


# Exit game.
func _on_exit_pressed():
	get_tree().quit()


# Emit a signal to start game.
func _on_new_game_pressed():
	hide()
	new_game_pressed.emit()

# Back to menu when show game over.
func _on_back_to_menu_game_over_pressed():
	v_box_container_actions.show()
	title.show()
	sub_title.show()
	v_box_container_actions.show()
	box_container_bottom.show()
	v_box_container_game_over.hide()

# Show game over screen.
func _show_game_over(score: int, new_best_score: bool):
	show()
	if (new_best_score):
		v_box_container_game_over.find_child('GameOverScoreLabel').text = 'New best score: ' + str(score)
	else:
		v_box_container_game_over.find_child('GameOverScoreLabel').text = 'Score: ' + str(score)
	title.hide()
	sub_title.hide()
	v_box_container_actions.hide()
	box_container_bottom.hide()
	v_box_container_game_over.show()
	


func _on_best_score_pressed():
	title.hide()
	sub_title.hide()
	menu_actions.hide()
	best_score_label.show()
	best_score_label.text = 'Best score: ' + str(DataManagement._load_data())


func _on_back_to_menu_best_score_pressed():
	title.show()
	sub_title.show()
	menu_actions.show()
	best_score_label.hide()


func _on_sound_button_pressed():
	sound_toggle.emit(find_child('AnimatedSprite2DSound'))
