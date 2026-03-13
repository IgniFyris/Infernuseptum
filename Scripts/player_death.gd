extends CanvasLayer

func _ready() -> void:
	var PrevScene = SceneLoader.get_previous_scene_path()
	print(PrevScene)
