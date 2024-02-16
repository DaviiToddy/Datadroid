extends EnemyMock

#func _ready():
#	$BehaviorTree/Blackboard.data += {"isPlayerNear": false}


func _on_PlayerWatcher_area_entered(area):
	$BehaviorTree.blackboard.data["isPlayerNear"] = true


func _on_PlayerWatcher_area_exited(area):
	$BehaviorTree.blackboard.data["isPlayerNear"] = false
