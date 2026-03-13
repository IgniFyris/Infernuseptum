extends Area2D

var SlothScene = "uid://dagyj4t8j84c4"
var GreedScene = "uid://bv7herqgc7fnv"
var LustScene = "uid://c725gkt87eq1a"
var EnvyScene = "uid://cmu8favv2d85q"
var GluttonyScene = "uid://d353el0o6o1go"
var WrathScene = "uid://b8keb87g85h2m"
var PrideScene = ""

func _ready() -> void:
	self.monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body is SPlayer && SceneLoader.scene_path == SlothScene:
		SceneLoader.load_scene(GreedScene)
	if body is GPlayer && SceneLoader.scene_path == GreedScene:
		SceneLoader.load_scene(LustScene)
	if body is LPlayer && SceneLoader.scene_path == LustScene:
		SceneLoader.load_scene(EnvyScene)
	if body is EPlayer && SceneLoader.scene_path == EnvyScene:
		SceneLoader.load_scene(GluttonyScene)
	if body is GLPlayer && SceneLoader.scene_path == GluttonyScene:
		SceneLoader.load_scene(WrathScene)
	if body is WPlayer && SceneLoader.scene_path == WrathScene:
		SceneLoader.load_scene(PrideScene)
