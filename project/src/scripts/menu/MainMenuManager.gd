extends CanvasLayer

onready var mainMenuScreens = {
	"title": $MainScreen,
	"preferences": Resource.new(),
	"about": Resource.new(),
	"armory": $Armory
}

export(NodePath) var current_screen
export(PackedScene) var main_scene

func _ready() -> void:
	if !current_screen:
		current_screen = $MainScreen
		_ready()
	if current_screen is NodePath:
		current_screen = get_node(current_screen)
	current_screen.show()

func _play_triggered():
	if main_scene as PackedScene:
		$Timer.start()
		yield($Timer, "timeout")
		get_tree().change_scene_to(main_scene)

func _hideCurrentScreen() -> void:
	if current_screen as Node:
		current_screen.hide()

func _changeScreen(screenNodeName: String) -> void:
	var control = mainMenuScreens[screenNodeName]
	if !control as Control:
		return
	$Timer.start()
	yield($Timer, "timeout")
	_hideCurrentScreen()
	current_screen = control
	current_screen.show()

func _on_quit_game_confirmed() -> void:
	get_tree().quit()
