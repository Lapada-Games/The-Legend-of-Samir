extends CharacterBody2D
class_name Player

signal attacked

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider is Enemy:
			if not collider.should_kill_player:
				$AnimationPlayer.play("run_attack")
				


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "run_attack":
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("run")
