extends Node2D

func _process(delta):
	if get_tree().get_nodes_in_group("zombies").size() == 0:
		$UILAYER/WINLABEL.visible = true
