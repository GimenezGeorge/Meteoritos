#EnemigoInterceptor.gd
class_name EnemigoInterceptor
extends EnemigoBase

## Enums
enum ESTADO_IA {IDLE, ATACANDOQ, ATACANDOP, PERSECUCION}

## Atributos
var estado_ia_actual:int = ESTADO_IA.IDLE

## Metodos Custom
func controlador_estados_ia(nuevo_estado: int) -> void:
	match nuevo_estado:
		ESTADO_IA.IDLE:
			canion.set_esta_disparando(false)
		ESTADO_IA.ATACANDOQ:
			canion.set_esta_disparando(true)
		ESTADO_IA.ATACANDOP:
			canion.set_esta_disparando(true)
		ESTADO_IA.PERSECUCION:
			canion.set_esta_disparando(false)
		_:
			printerr("Error de estado")
	
	estado_ia_actual = nuevo_estado

## Señales Internas
# warning-ignore:unused_argument
func _on_AreaDisparo_body_entered(body: Node) -> void:
	controlador_estados_ia(ESTADO_IA.ATACANDOP)

# warning-ignore:unused_argument
func _on_AreaDisparo_body_exited(body: Node) -> void:
	controlador_estados_ia(ESTADO_IA.PERSECUCION)

# warning-ignore:unused_argument
func _on_AreaDeteccion_body_entered(body: Node) -> void:
	controlador_estados_ia(ESTADO_IA.ATACANDOQ)

# warning-ignore:unused_argument
func _on_AreaDeteccion_body_exited(body: Node) -> void:
	controlador_estados_ia(ESTADO_IA.ATACANDOP)
