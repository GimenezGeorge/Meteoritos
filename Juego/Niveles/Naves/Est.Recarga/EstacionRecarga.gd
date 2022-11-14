class_name EstacionRecarga
extends Node2D

export var energia:float = 8.0
export var radio_energia_entregada:float = 0.05

onready var carga_sfx:AudioStreamPlayer2D = $CargaSFX

var nave_player:Player = null
var player_en_zona:bool = false

func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
#
#	energia -= radio_energia_entregada
	controlar_energia()
	
	if event.is_action("rec_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	elif event.is_action("rec_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)

func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body: Node) -> void:
	if body is Player:
		nave_player = body
		player_en_zona = true
	
	body.set_gravity_scale(0.1)

func _on_AreaRecarga_body_exited(body: Node) -> void:
	body.set_gravity_scale(0.0)
	player_en_zona = false

func puede_recargar(event: InputEvent) -> bool:
	var hay_input = event.is_action("rec_escudo") or event.is_action("rec_laser")
	if hay_input and player_en_zona and energia > 0.0:
		if !carga_sfx.playing:
			carga_sfx.play()
		return true
	
	return false

func controlar_energia() -> void:
	energia -= radio_energia_entregada
	if energia <= 0.0:
		$VacioSFX.play()
	print("Energia Estacion: ", energia)
