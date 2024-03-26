extends CharacterBody2D
class_name Player


@export var speed: int
@export var texture: PlayerTexture

#Godot recomenda usar essa funcão para objetos que usam a física. Funções proprias da godot não precisa especificar
#se é void ou não.
func _physics_process(delta: float):
	horizontal_moviment_env()
	#Esse é um metódo do KinematicBody que aplica uma velocidade linear ao objeto e apartir disso ele vai movimentar 
	#o personagem, a vantagem é que além de movimentar o personagem, ele vai slidar. Slide faz com que ele se movimente
	#e quando ele encontrar uma colisão dependendo dos parâmetros ele vai executar determinadas ações, se não 
	#especificar um parâmetro quando ele encontrar uma colisão ele vai parar.
	move_and_slide()
	#player_texture.animate()
	
func horizontal_moviment_env() -> void:
	#Aqui vai retornar qual é a direção. Se for para a esquerda é -1, se for para a direita é 1
	#e ao pressionar os dois ou nenhum será 0.
	var direction: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if direction:
		velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
