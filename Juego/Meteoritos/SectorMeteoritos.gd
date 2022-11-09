class_name SectorMeteoritos
extends Node2D

export var cantidad_meteoritos:int = 10
export var intervalo_spawn:float = 1.2

var spawners:Array

func _ready() -> void:
	almacenar_spawners()
	conectar_seniales_detectores()
	$SpawnTimer.wait_time = intervalo_spawn

func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func crear(pos: Vector2, meteoritos: int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos

func conectar_seniales_detectores() -> void:
	for detector in $DetectoresFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")
		
func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()

func _on_detector_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)

func _on_SpawnTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
	
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1
