extends Resource

class_name ResDadosExecucao

enum States {
	GAMEPLAY, PAUSE, MENU
}

export(States) var estado_atual = States.GAMEPLAY
