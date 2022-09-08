extends Node2D


func _ready() -> void:
	# Hay que forzar la actualizacion del mapa para poder calcular un path en _ready
	Navigation2DServer.map_force_update(get_world_2d().navigation_map)
	# Ahora se obtiene el path desde el punto inicial hasta el final
	var path := Navigation2DServer.map_get_path(
		get_world_2d().navigation_map, # El mapa global usado por la navegación
		$Start.global_position, # El punto inicial en coordenadas globales
		$End.global_position, # El punto final en coordenadas globales
		true, # true para optimizar, falso sino
		1 # Bitmask de las layers posibles, en este caso solo la 1
	)
	# Y se grafica finalmente con una Line2D
	$Line2D.points = path
