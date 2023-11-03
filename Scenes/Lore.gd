extends CanvasLayer

var texts = [
	"Há muito tempo, antes do tempo se chamar tempo... Só havia o caos e o vazio",
	"Até que surgem 3 grandes deuses: Pitágoras, deus da Geometria; Gauss, deus da Álgebra; e Arquimedes, deus da Aritmética.",
	"Juntos, eles criaram o Universo da Matemática, juntamente com diversos reinos...",
	"...um deles sendo o Reino dos Números. Um reino habitado por seres fantásticos e civilizações humanas.",
	"Então os deuses deixaram como presente para a humanidade A Concha Sagrada da Matemática.",
	"Essa concha é um artefato poderoso capaz de manter a paz e harmonia no universo.",
	"Porém, um terrível vilão, chamado Euler, aparece e rouba a Concha.",
	"Mas existe uma lenda. De um herói destemido que irá deter o grande vilão e restaurar a paz no reino.",
	"Seu nome é Samir, um habitante do Reino dos Números. Seu objetivo é recuperar A Concha.",
	"Só que para isso, você precisa enfrentar O CASTELO DE EULER!"
]

var extensions = [
	".jpg",
	".jpg",
	".jpg",
	".jpg",
	".png",
	".jpg",
	".jpg",
	".jpeg",
	".png",
	".jpeg"
]

var current_text = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	reload()
	$Legenda.text = texts[current_text]
	


func reload():
	if current_text > 9:
		$AnimationPlayer2.play("fade_out")
		return
	$Legenda.text = texts[current_text]
	$Slide.texture = load("res://Assets/Lore/" + str(current_text) + extensions[current_text])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")


func _on_timer_timeout():
	current_text += 1
	reload()

func end():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

