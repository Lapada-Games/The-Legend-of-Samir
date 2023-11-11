extends Node2D

var player_hp = 3
var boss_hp = 6
var game_over = false

func _ready():
	if Global.difficulty == Global.MEDIUM:
		player_hp = 4
		boss_hp = 10
	elif Global.difficulty == Global.HARD:
		player_hp = 5
		boss_hp = 16
	
	$PlayerHP.max_value = player_hp
	$BossHP.max_value = boss_hp
	$PlayerHP.value = player_hp
	$BossHP.value = boss_hp
	
	$Comparations.setup(player_hp, boss_hp)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and game_over:
		get_tree().reload_current_scene()
		


func boss_lose_hp():
	$BossHP.value -= 1
	if $BossHP.value == 0:
		$Comparations.disabled = true
		$Comparations.visible = false
		$BossAnimations.play("euler_dead")

func player_lose_hp():
	$PlayerHP.value -= 1
	if $PlayerHP.value == 0:
		$Comparations.disabled = true
		$Comparations.visible = false
		$SamirRig/SamirAnimations.play("dead2")

func set_game_over(game_over):
	self.game_over = game_over

func _on_comparations_success():
	$SamirRig/SamirAnimations.play("attack")

func _on_comparations_failed():
	$BossAnimations.play("euler_attack")


func _on_samir_rig_attacked():
	$Comparations.next_question()
	

func _on_euler_attacked():
	$Comparations.next_question()
	


func _on_samir_animations_animation_finished(anim_name):
	if anim_name == "attack":
		$SamirRig/SamirAnimations.play("idle")
	elif anim_name == "shell_coming":
		get_tree().change_scene_to_file("res://Scenes/ending.tscn")


func _on_boss_animations_animation_finished(anim_name):
	if anim_name == "euler_dead":
		$SamirRig/SamirAnimations.play("shell_coming")
