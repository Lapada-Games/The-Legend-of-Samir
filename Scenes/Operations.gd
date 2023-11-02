extends Node2D

signal success



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_test_timeout():
	emit_signal("success") # TESTE
