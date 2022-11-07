class_name Meteorito
extends RigidBody2D

export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

onready var impacto_sfx = $Impacto_SFX
onready var impacto_anim = $AnimationPlayer

var hitpoints:float

func _ready() -> void:
	linear_velocity = vel_lineal_base
	angular_velocity = vel_ang_base

func crear(pos: Vector2, dir: Vector2, tamanio:float) -> void:
	position = pos
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	#radio = diametro / 2
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	linear_velocity = vel_lineal_base * dir / tamanio
	angular_velocity = vel_ang_base / tamanio
	hitpoints = hitpoints_base * tamanio

func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0:
		destruir()
		
	impacto_sfx.play()
	impacto_anim.play("impacto")

func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
