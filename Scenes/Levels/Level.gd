extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_operations_success():
	var enemy = null
	if $EnemySpawner.has_enemy():
		enemy = $EnemySpawner.instance
		enemy.should_kill_player = false
		enemy.speed += 120
		




func _on_samir_rig_attacked():
	if $EnemySpawner.has_enemy():
		$EnemySpawner.kill_enemy()
		$EnemySpawner.spawn_enemy()
	
	$Operations.next_question()


func _on_samir_rig_dead():
	$TileMap.paused = true
	$ParallaxBackground.paused = true


func _on_operations_failed():
	var enemy = null
	if $EnemySpawner.has_enemy():
		enemy = $EnemySpawner.instance
		enemy.speed += 200
