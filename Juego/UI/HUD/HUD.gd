#HUD
extends CanvasLayer

onready var info_zona_recarga:ContenedorInformacion = $InfoZonaRecarga
onready var info_meteoritos:ContenedorInformacion = $InfoMeteoritos

func _ready() -> void:
	conectar_seniales()

func conectar_seniales() -> void:
# warning-ignore:return_value_discarded
	Eventos.connect("nivel_iniciado", self, "fade_out")
# warning-ignore:return_value_discarded
	Eventos.connect("nivel_terminado", self, "fade_in")
# warning-ignore:return_value_discarded
	Eventos.connect("detecto_zona_recarga", self, "_on_detecto_zona_recarga")
# warning-ignore:return_value_discarded
	Eventos.connect("cambio_numero_meteoritos", self, "_on_actualizar_info_meteoritos")

func fade_in() -> void:
	$FadeCanvas/AnimationPlayer.play("fade_in")
	
func fade_out() -> void:
	$FadeCanvas/AnimationPlayer.play_backwards("fade_in")

func _on_detecto_zona_recarga(en_zona: bool) -> void:
	if en_zona:
		info_zona_recarga.mostrar_suavizado()
	else:
		info_zona_recarga.ocultar_suavizado()

func _on_actualizar_info_meteoritos(numero: int) -> void:
	info_meteoritos.mostrar_suavizado()
	info_meteoritos.modificar_texto("Meteoritos Restantes\n {cantidad}".format({"cantidad":numero}))
