#MiniMapa.gd
extends MarginContainer

export var escala_zoom:float = 4.0

onready var zona_renderizado:TextureRect = $FondoMiniMapa/Iconos/RenderizadoMiniMapa
onready var icono_player:Sprite = $FondoMiniMapa/Iconos/RenderizadoMiniMapa/Player

var escala_grilla:Vector2
var player:Player = null

func _ready() -> void:
	set_process(false)
	icono_player.position = zona_renderizado.rect_size * 0.5
	escala_grilla = zona_renderizado.rect_size / (get_viewport_rect().size * escala_zoom)
# warning-ignore:return_value_discarded
	Eventos.connect("nivel_iniciado", self, "_on_nivel_iniciado")
# warning-ignore:return_value_discarded
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")

func _process(_delta: float) -> void:
	if not player:
		return
	
	icono_player.rotation_degrees = player.rotation_degrees + 90

func _on_nivel_iniciado() -> void:
	player = DatosJuego.get_player_actual()
	set_process(true)

func _on_nave_destruida(nave: NaveBase, _posicion, _explosiones) -> void:
	if nave is Player:
		player = null
