extends CharacterBody2D
class_name Enemy

const SPEED = 130.0

var should_kill_player = true

func _physics_process(delta):
	velocity.x = -1 * SPEED

	move_and_slide()
	
	
	if $RayCast2D.is_colliding() and should_kill_player:
		var collider = $RayCast2D.get_collider()
		if $RayCast2D.get_collider() is Player:
			collider.die()
