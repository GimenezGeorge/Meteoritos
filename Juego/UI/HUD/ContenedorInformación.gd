class_name ContenedorInformacion
extends NinePatchRect

export var auto_ocultar:bool = false

onready var texto_contenedor:Label = $Label
onready var auto_ocultar_timer:Timer = $AutoOcultarTimer
onready var animaciones:AnimationPlayer = $AnimationPlayer

func modificar_texto(text: String) -> void:
	texto_contenedor.text = text

func mostrar() -> void:
	animaciones.play("Mostrar")

func ocultar() -> void:
	animaciones.play("Ocultar")

func mostrar_suavizado() -> void:
	animaciones.play("mostrar_suavizado")
	if auto_ocultar:
		auto_ocultar_timer.start()

func ocultar_suavizado() -> void:
	animaciones.play("ocultar_suavizado")

func _on_AutoOcultarTimer_timeout() -> void:
	ocultar_suavizado()
