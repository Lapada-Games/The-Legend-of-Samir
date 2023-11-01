extends CanvasLayer

var texts = [
	"Há muito tempo, antes do tempo se chamar tempo... Só havia o caos e o vazio",
	"Até que surgem 3 grandes deuses: Pitágoras, deus da Geometria; Gauss, deus da Álgebra; e Arquimedes, deus da Aritmética.",
	"Juntos, eles criaram o Universo da Matemática, juntamente com diversos reinos...",
	"...um deles sendo o Reino dos Números. Um reino habitado por seres fantásticos e civilizações humanas.",
	"Então os deuses deixaram como presente para a humanidade A Concha Sagrada da Matemática.",
	"Essa concha é um artefato poderoso capaz de manter a paz e harmonia no universo.",
	"Porém, um terrível vilão, chamado Euler, aparece e rouba a Concha e, com ela, ele será capaz de governar todos os Reinos da Matemática.",
	"Mas existe uma lenda. De um herói destemido que irá deter o grande vilão e restaurar a paz no reino.",
	"Você é Samir, um habitante do Reino dos Números. Seu objetivo é recuperar A Concha, que está trancada no Castelo de Euler. Mas para isso, você precisa resolver diversos enigmas matemáticos espalhados pelo reino para obter os fragmentos da chave que guardam a concha.",
	"Boa sorte!"
]

var current_text = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reload()


func reload():
	$Legenda.text = texts[current_text]
	$Slide.texture = load("res://Assets/Lore/" + str(current_text) + ".jpg")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	current_text += 1
	reload()
