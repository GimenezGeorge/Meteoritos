#HUD
extends CanvasLayer

onready var info_zona_recarga:ContenedorInformacion = $InfoZonaRecarga
onready var info_meteoritos:ContenedorInformacion = $InfoMeteoritos
onready var info_tiempo_restante:ContenedorInformacion = $InfoTiempoRestante

#func set_auto_ocultar

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
# warning-ignore:return_value_discarded
	Eventos.connect("actualizar_tiempo", self, "_on_actualizar_info_tiempo")

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

func _on_actualizar_info_tiempo(tiempo_restante: int) -> void:
# warning-ignore:narrowing_conversion
	var minutos:int = floor(tiempo_restante * 0.01666666666667)
	var segundos:int = tiempo_restante % 60
	info_tiempo_restante.modificar_texto(
		"Tiempo restante\n%02d:%02d" % [minutos, segundos]
	)
	
	if tiempo_restante % 10 == 0:
		info_tiempo_restante.mostrar_suavizado()
	
	if tiempo_restante == 11:
		info_tiempo_restante.set_auto_ocultar(false)
	elif tiempo_restante == 0:
		info_tiempo_restante.ocultar()
