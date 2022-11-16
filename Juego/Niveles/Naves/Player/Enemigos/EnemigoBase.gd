class_name EnemigoBase
extends NaveBase

## Atributos
var player_objetivo:Player = null

## Metodos
func _ready() -> void:
	player_objetivo = DatosJuego.get_player_actual()
# warning-ignore:return_value_discarded
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
	#Temporal
#	canion.set_esta_disparando(true)

func _physics_process(_delta: float) -> void:
	rotar_hacia_player()

## Metodos Custom
func _on_nave_destruida(nave: NaveBase, _posicion, _explosiones) -> void:
	if nave is Player:
		player_objetivo = null

func rotar_hacia_player() -> void:
	if player_objetivo:
		var dir_player:Vector2 = player_objetivo.global_position - global_position
		rotation = dir_player.angle()

## Señales Internas
func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()
