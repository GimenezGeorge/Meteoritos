class_name EstacionRecarga
extends Node2D

export var energia:float = 8.0
export var radio_energia_entregada:float = 0.05

onready var carga_sfx:AudioStreamPlayer2D = $CargaSFX
onready var barra_energia:ProgressBar = $BarraEnergia

var nave_player:Player = null
var player_en_zona:bool = false

func _ready() -> void:
	barra_energia.max_value = energia
	barra_energia.value = energia

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
	
	if event.is_action_released("rec_escudo"):
		Eventos.emit_signal("ocultar_energia_escudo")
	elif event.is_action_released("rec_laser"):
		Eventos.emit_signal("ocultar_energia_laser")

func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body: Node) -> void:
	if body is Player:
		nave_player = body
		player_en_zona = true
		Eventos.emit_signal("detecto_zona_recarga", true)

# warning-ignore:unused_argument
func _on_AreaRecarga_body_exited(body: Node) -> void:
	if body is Player:
			player_en_zona = false
			Eventos.emit_signal("detecto_zona_recarga", false)

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

	barra_energia.value = energia
