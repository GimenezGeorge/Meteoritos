class_name EstacionRecarga
extends Node2D

export var energia:float = 6.0
export var radio_energia_entregada:float = 0.05

var nave_player:Player = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("rec_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	elif event.is_action("rec_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)

func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body: Node) -> void:
	if body is Player:
		nave_player = body
	
	body.set_gravity_scale(0.1)

func _on_AreaRecarga_body_exited(body: Node) -> void:
	body.set_gravity_scale(0.0)
