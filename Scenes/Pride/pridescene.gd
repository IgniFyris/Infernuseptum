extends Node2D

@onready var Portal = $Portal
@onready var Player = $Player

@onready var Bar1 = $PrideLevel/BossBar/Sprite2D
@onready var Bar2 = $PrideLevel/BossBar/Sprite2D2
@onready var Bar3 = $PrideLevel/BossBar/Sprite2D3
@onready var Bar4 = $PrideLevel/BossBar/Sprite2D4
@onready var Bar5 = $PrideLevel/BossBar/Sprite2D5
@onready var Bar6 = $PrideLevel/BossBar/Sprite2D6

@onready var orbs = $PrideLevel/Orbs

var orbs_scene : PackedScene = preload("res://Scenes/Pride/Porbs.tscn") 
@export var death_scene: StringName = &""

func _ready() -> void:
	Portal.monitoring = false
	Portal.visible = false

func _process(_delta: float) -> void:
	if Player.pride_meter == 0:
		Bar1.visible = true
		Bar2.visible = false
		Bar3.visible = false
		Bar4.visible = false
		Bar5.visible = false
		Bar6.visible = false
	if Player.pride_meter == 1:
		Bar1.visible = false
		Bar2.visible = true
		Bar3.visible = false
		Bar4.visible = false
		Bar5.visible = false
		Bar6.visible = false
	if Player.pride_meter == 2:
		Bar1.visible = false
		Bar2.visible = false
		Bar3.visible = true
		Bar4.visible = false
		Bar5.visible = false
		Bar6.visible = false
	if Player.pride_meter == 3:
		Bar1.visible = false
		Bar2.visible = false
		Bar3.visible = false
		Bar4.visible = true
		Bar5.visible = false
		Bar6.visible = false
	if Player.pride_meter == 4:
		Bar1.visible = false
		Bar2.visible = false
		Bar3.visible = false
		Bar4.visible = false
		Bar5.visible = true
		Bar6.visible = false
	if Player.pride_meter == 5:
		Bar1.visible = false
		Bar2.visible = false
		Bar3.visible = false
		Bar4.visible = false
		Bar5.visible = false
		Bar6.visible = true
		
	if orbs.get_child_count() != 1:
		var POrbs = orbs_scene.instantiate()
		orbs.add_child(POrbs)
		POrbs.z_index = 90


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PPlayer:
		body.dead = true
		body.WPlayerAnim.play("death")
		SceneLoader.load_scene(death_scene)
