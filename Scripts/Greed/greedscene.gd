extends Node2D

@onready var GReceivers = $GReceivers
@onready var GShop = $Shop
@onready var GShopCam = $Shop/Camera2D
@onready var Portal = $Portal
@onready var PlayerCam = $GPlayer/Camera2D
@onready var Player = $GPlayer
@onready var GQuestionnaire = $GQuestion

var CutsceneDone = false

func _ready() -> void:
	Portal.visible = false
	Portal.monitoring = false
	GShop.modulate.a = 0
	GShop.monitoring = false

func _process(_delta: float) -> void:
	if GReceivers.get_child_count() == 0 and not CutsceneDone:
		PlayerCam.enabled = false
		GShopCam.enabled = true
		Player.cam = true
		var tw = create_tween().tween_property(GShop, "modulate:a", 1, 2.5)
		
		await tw.finished
		
		GShopCam.enabled = false
		Player.cam = false
		PlayerCam.enabled = true
		GShop.monitoring = true
		CutsceneDone = true

func _on_g_question_pressed_right() -> void:
	Portal.visible = true
	Portal.monitoring = true
	PlayerCam.enabled = true
	Player.cam = false

func _on_shop_player_entered_shop() -> void:
	GQuestionnaire.visible = true
	PlayerCam.enabled = false
	Player.Bag.visible = false
	Player.cam = true
