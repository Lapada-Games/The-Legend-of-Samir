extends CharacterBody2D
class_name Player

signal attacked
signal dead

var rng = RandomNumberGenerator.new()
var is_dead = false
var can_run_away = false
@onready var audios = [
	$Audios/Yah,
	$Audios/Yah2,
	$Audios/Yah3
]


func _physics_process(delta):
	
	if can_run_away:
		position.x += 300 * delta
		
		if position.x > 800:
			Global.level += 1
			get_tree().change_scene_to_file("res://Scenes/LevelShower.tscn")
		
		
	
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider is Enemy:
			if not collider.should_kill_player:
				$AnimationPlayer.play("run_attack")

func yah():
	audios[rng.randi_range(0, 2)].play()

func die():
	if not is_dead:
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("dead")
		is_dead = true
		$Audios/Hurt.play()
		emit_signal("dead")

func run_away():
	can_run_away = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "run_attack":
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("run")
