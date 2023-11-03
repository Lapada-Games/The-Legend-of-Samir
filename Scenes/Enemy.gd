extends CharacterBody2D
class_name Enemy

var speed = 80
var rng = RandomNumberGenerator.new()
var should_kill_player = true
var attacking = false
var dead = false

var sprites = [
	"fox",
	"toad",
	"thief_fox"
]

var current_sprite = 0

func randomize_sprite():
	if Global.level == 0 or Global.level == 1:
		current_sprite = rng.randi_range(0, 1)
	elif Global.level == 2:
		current_sprite = rng.randi_range(1, 2)

func _physics_process(delta):
	velocity.x = -1 * speed

	move_and_slide()
	
	if dead:
		$Sprite2D.play(sprites[current_sprite] + "_die")
	else:
		if not attacking:
			$Sprite2D.play(sprites[current_sprite] + "_walk")
		else:
			$Sprite2D.play(sprites[current_sprite] + "_attack")
		
	
	if $RayCast2D.is_colliding() and should_kill_player:
		var collider = $RayCast2D.get_collider()
		if $RayCast2D.get_collider() is Player:
			if not collider.can_run_away:
				attacking = true
				collider.die() # the player dies
				$RayCast2D.enabled = false


func die():
	dead = true


func _on_sprite_2d_animation_finished():
	if $Sprite2D.animation == sprites[current_sprite] + "_attack":
		attacking = false
	elif $Sprite2D.animation == sprites[current_sprite] + "_die":
		queue_free()
