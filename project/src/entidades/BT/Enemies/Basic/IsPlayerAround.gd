extends BTConditional

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if blackboard.data["isPlayerNear"]:
		return succeed()
	return fail()
