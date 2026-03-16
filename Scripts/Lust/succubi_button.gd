extends TextureButton

@onready var SelfDestructTimer = $SelfDestruct

@onready var LButton = $AudioStreamPlayer2D

@export var DeathScene = "uid://br7ao02pl5e7w"

func _ready() -> void:
	self.visible = false
	self.position = Vector2(randf_range(150, 1100), randf_range(100, 620))
	self.visible = true
	SelfDestructTimer.start()
	
func _process(_delta: float) -> void:
	if not SelfDestructTimer.is_stopped():
		create_tween().tween_property(self, "size", Vector2(0.0, 0.0), 5)
	if SelfDestructTimer.is_stopped():
		var parent_node = get_parent()
		if parent_node:
			var siblings_list = parent_node.get_children()
			for sibling in siblings_list:
				if sibling != self and (sibling.name == "BG1s" or sibling.name == "BG2s" or sibling.name == "BG3s" or sibling.name == "ButtonCreationTimer"):
					sibling.queue_free()
		SceneLoader.load_scene(DeathScene)
		parent_node.queue_free()
		

func _on_pressed() -> void:
	queue_free()
