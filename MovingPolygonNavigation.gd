extends Node2D


func _ready() -> void:
	# Utiliza un tween para mover la MovingZone
	var tween := create_tween().set_loops().set_trans(Tween.TRANS_SINE) # Setear loop infinito
	tween.tween_property($MovingZone, "position:y", 64.0, 2) # Primero se mueve hacia abajo
	tween.tween_property($MovingZone, "position:y", -64.0, 2) # Y luego hacia arriba
	# Nota: la zona se mueve hasta 64 y -64, son posiciones absolutas.


func _physics_process(_delta: float) -> void:
	# Basta con obtener el path nuevamente, el NavigationServer se encarga de todo
	var path := Navigation2DServer.map_get_path(
		get_world_2d().navigation_map, # El mapa
		$Start.global_position, # El punto inicial en coordenadas globales
		$End.global_position, # El punto final en coordenadas globales
		true, # true para optimizar, falso sino
		4 # Bitmask de las layers posibles, en este caso solo la 3
	)
	# Y se grafica
	$Line2D.points = path
