extends CanvasLayer

class_name UI

var total_score = 0

var tools = Tools.new()

enum GAMESTATE {
	MENU, GAME, PAUSE, GAMEOVER
}

onready var state_game = GAMESTATE.MENU
onready var last_state_game = state_game

func _ready():
	menu()

func menu():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	last_state_game = state_game
	state_game = GAMESTATE.MENU
	hide()

func game(fade: bool):
	if fade:
		$AnimationPlayer.play("FadeIn")
	$Game.show()
	$Pause.hide()
	$GameOver.hide()
	show()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	last_state_game = state_game
	state_game = GAMESTATE.GAME
	get_tree().paused = false

func pausedGame():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
	last_state_game = state_game
	state_game = GAMESTATE.PAUSE
	get_tree().paused = true
	$Pause.show()
	$GameOver.hide()

func gameOver():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()
	last_state_game = state_game
	state_game = GAMESTATE.GAMEOVER
	get_tree().paused = true
	$Game.hide()
	$Pause.hide()
	$GameOver.show()

func update_score(score, sum):
	
	if sum:
		total_score += score
		var mask = tools.mask(total_score, "000")
		$Game/Label2.set_deferred("text", str("Score: ", mask))
		return
	
	var mask = tools.mask(score, "000")
	$Game/Label2.set_deferred("text", str("Score: ", mask))

func debug_text(text: String = "DEBUG TEXT", position: int = 0):
	if position == 0:
		$Control/Label.text = str(text)
	elif position == 1:
		$Control/Label2.text = str(text)
	else:
		$Control/Label.text = str(text)

func _process(delta):
	
	if Input.is_action_just_pressed("ui_cancel"):
		if state_game == GAMESTATE.GAME:
			pausedGame()
		elif state_game == GAMESTATE.PAUSE:
			game(false)
