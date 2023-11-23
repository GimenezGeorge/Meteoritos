#FondoEstrellas.gd
tool
extends ParallaxBackground

export var color_fondo:Color = Color.black

func _ready() -> void:
	$ColorRect.color = color_fondo

# warning-ignore:unused_argument
func _process(delta: float) -> void:
	if Engine.editor_hint:
		$ColorRect.color = color_fondo
