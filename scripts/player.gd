extends CharacterBody2D

const WALK_SPEED = 150.0
const RUN_SPEED = 250.0

@onready var anim = $AnimatedSprite2D
var ultima_direcao = "F" 

func _physics_process(_delta):
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# 2. Velocidade baseada no Shift
	var is_running = Input.is_action_pressed("ui_shift")
	var current_speed = RUN_SPEED if is_running else WALK_SPEED

	if direction != Vector2.ZERO:
		velocity = direction * current_speed
		_processar_animacao_movimento(direction, is_running)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, current_speed)
		_processar_idle()

	move_and_slide()

func _processar_animacao_movimento(dir: Vector2, correndo: bool):
	var acao = "correndo" if correndo else "andando"
	
	
	if dir.y < 0:
		ultima_direcao = "A" # Atrás
	elif dir.y > 0:
		ultima_direcao = "F" # Frente
	elif dir.x > 0:
		ultima_direcao = "D" # Direita
	elif dir.x < 0:
		ultima_direcao = "E" # Esquerda
	
	
	anim.play(acao + ultima_direcao + "_idle")

func _processar_idle():
	
	if ultima_direcao == "A":
		anim.play("atras_idle")
	elif ultima_direcao == "F":
		anim.play("frente_idle")
	elif ultima_direcao == "D":
		anim.play("ladoD_idle") # Ajustei 'edle' para 'idle' conforme o padrão
	elif ultima_direcao == "E":
		anim.play("ladoE_idle")
