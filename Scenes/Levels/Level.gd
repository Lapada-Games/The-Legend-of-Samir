extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_operations_success():
	var enemy = null
	if $EnemySpawner.has_enemy():
		enemy = $EnemySpawner.instance
		enemy.should_kill_player = false
		




func _on_samir_rig_attacked():
	if $EnemySpawner.has_enemy():
		$EnemySpawner.delete_enemy()


func _on_samir_rig_dead():
	$TileMap.paused = true
	$ParallaxBackground.paused = true
