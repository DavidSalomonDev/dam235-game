class_name Personaje
extends CharacterBody2D

signal player_hit()

@export var gravity = 100
@export var jump_speed = 100
@export var speed = 100
@onready var sprite_2d = $Sprite2D
@onready var audio_jump = $AudioJump


func _physics_process(delta):
	
	#horizontal
	var direction = Input.get_axis("izquierda", "derecha")
	velocity.x = speed * direction
	
	if direction != 0:
		sprite_2d.scale.x = direction
	
	#gravedad
	if not is_on_floor():
		velocity.y = velocity.y + gravity * delta
	
	#saltar
	var jump_pressed = Input.is_action_just_pressed("saltar")
	if jump_pressed and is_on_floor():
		velocity.y = velocity.y - jump_speed
		audio_jump.play()
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	print("El personaje a llegado a la meta: ", body.name)
	
	
func damage_received():
	print("Impacto de bomba")
	player_hit.emit()
