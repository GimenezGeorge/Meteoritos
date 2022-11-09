class_name CamaraPlayer
extends CamaraJuego

export var variacion_zoom:float = 0.1
export var zoom_minimo:float = 0.8
export var zoom_maximo:float = 1.5

onready var tween_zoom:Tween = $TweenZoom

var zoom_original:Vector2
var puede_hacer_zoom:bool = true setget set_puede_hacer_zoom

func set_puede_hacer_zoom(puede: bool) -> void:
	puede_hacer_zoom = puede

func _ready() -> void:
	zoom_original = zoom

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		controlar_zoom(-variacion_zoom)
	elif event.is_action_pressed("zoom_out"):
		controlar_zoom(variacion_zoom)

func controlar_zoom(mod_zoom: float) -> void:
	var zoom_x = clamp(zoom.x + mod_zoom, zoom_minimo, zoom_maximo)
	var zoom_y = clamp(zoom.y + mod_zoom, zoom_minimo, zoom_maximo)
	zoom_suavizado(zoom_x, zoom_y, 0.15)

func zoom_suavizado(nuevo_zoom_x: float, nuevo_zoom_y: float, tiempo_transicion: float) -> void:
# warning-ignore:return_value_discarded
	tween_zoom.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(nuevo_zoom_x, nuevo_zoom_y),
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
# warning-ignore:return_value_discarded
	tween_zoom.start()

func devolver_zoom_original() -> void:
	puede_hacer_zoom = false
	zoom_suavizado(zoom_original.x, zoom_original.y, 1.0)
