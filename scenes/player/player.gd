extends CharacterBody2D
class_name Player

@onready var texture: Sprite2D = get_node("Texture")

var jump_count: int = 0
var landing: bool = false

@export var speed: int
@export var jump_speed: int
@export var player_gravity: int

func _physics_process(delta):
	horizontal_moviment_env()
	vertical_moviment_env()
	gravity(delta)
	move_and_slide()
	texture.animate(velocity)
	
func horizontal_moviment_env() -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
func vertical_moviment_env() -> void:
	#Essa condição é necessária para resetar os pulos e a pessoa poder da mais 2 pulos, se essa condição
	#for colocada depois do ins_action_just... ele vai passar a dar 3 pulos.
	if is_on_floor():
		jump_count = 0
	#Essa condição faz o jogador dar 2 pulos e ele analisa se a pessoa aperta o espaço e segurar ou
	#aperta rapidamente, ele fará apenas uma vez a ação.
		if Input.is_action_just_pressed("jump") and is_on_floor() and jump_count < 2:
			jump_count += 1
			velocity.y = jump_speed
	
	
#Aplicando a velocidade em y, delta e valor de gravidade a cada frame.
func gravity(delta: float) -> void:
	velocity.y += delta * player_gravity
	#Limitador de velocidade de queda na vertical.
	if velocity.y >= player_gravity:
		velocity.y = player_gravity
