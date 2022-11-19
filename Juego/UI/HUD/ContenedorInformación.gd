class_name ContenedorInformacion
extends NinePatchRect

func mostrar() -> void:
	$AnimationPlayer.play("Mostrar")

func ocultar() -> void:
	$AnimationPlayer.play("Ocultar")

func mostrar_suavizado() -> void:
	$AnimationPlayer.play("mostrar_suavizado")

func ocultar_suavizado() -> void:
	$AnimationPlayer.play("ocultar_suavizado")
