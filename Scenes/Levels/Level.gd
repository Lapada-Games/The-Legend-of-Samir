extends Node2D


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
	$AfterDeath.start()
	$Operations.disable()


func _on_operations_failed():
	var enemy = null
	if $EnemySpawner.has_enemy():
		enemy = $EnemySpawner.instance
		enemy.speed += 200


func _on_after_death_timeout():
	get_tree().reload_current_scene()


func _on_operations_ended():
	print("gg")
	var enemy = null
	if $EnemySpawner.has_enemy():
		enemy = $EnemySpawner.instance
		enemy.queue_free()
		
	$SamirRig.run_away()
