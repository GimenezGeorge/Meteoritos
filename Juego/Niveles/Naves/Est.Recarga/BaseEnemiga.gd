class_name BaseEnemiga
extends Node2D

export var hitpoints:float = 30.0
export var orbital:PackedScene = null

onready var impacto_sfx:AudioStreamPlayer2D = $ImpactoSFX

var esta_destruida:bool = false

func _ready() -> void:
	$AnimationPlayer.play(elegir_animacion_aleatoria())

func elegir_animacion_aleatoria() -> String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria:int = randi() % num_anim + 1
	var lista_animacion:Array = $AnimationPlayer.get_animation_list()
	
	return lista_animacion[indice_anim_aleatoria]

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	
	if hitpoints <= 0 and not esta_destruida:
		esta_destruida = true
		queue_free()
	
	impacto_sfx.play()

func destruir() -> void:
	var posicion_partes = [
		$Sprites/Parte2.global_position,
		$Sprites/Parte3.global_position,
		$Sprites/Parte4.global_position,
		$Sprites/Parte1.global_position
	]
	
	Eventos.emit_signal("base_destruida", posicion_partes)
	queue_free()

func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_VisibilityNotifier2D_screen_entered() -> void:
	#Spawn Orbital
	$VisibilityNotifier2D.queue_free()
	
	var new_orbital:EnemigoOrbital = orbital.instance()
	new_orbital.crear(
		global_position + $PosicionesSpawn/Norte.global_position,
		self
	)
	Eventos.emit_signal("spawn_orbital", new_orbital)
