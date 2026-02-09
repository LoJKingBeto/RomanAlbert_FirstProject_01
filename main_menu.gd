extends Control

@export var gameplay_scene: PackedScene

func _on_play_button_pressed() -> void:
	if gameplay_scene:
		get_tree().change_scene_to_packed(gameplay_scene)
	else:
		push_error("MainMenu: gameplay_scene is not set!")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
