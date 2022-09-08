extends Node2D


func _ready() -> void:
	# Hay que forzar la actualizacion del mapa para poder calcular un path en ready
	Navigation2DServer.map_force_update(get_world_2d().navigation_map)
	
	# Ahora se obtienen los paths, es lo mismo que en Static Navigation pero con distintas layers
	# Layer 1 (Polígono azul)
	var path1 := Navigation2DServer.map_get_path(
		get_world_2d().navigation_map, # El mapa
		$Start.global_position, # El punto inicial en coordenadas globales
		$End.global_position, # El punto final en coordenadas globales
		true, # true para optimizar, falso sino
		1 # Bitmask de las layers posibles, en este caso solo la 1
	)
	# Y se grafica con una Line2D
	$Layer1Line2D.points = path1
	
	# Layer 2 (Polígono verde)
	var path2 := Navigation2DServer.map_get_path(
		get_world_2d().navigation_map, # El mapa
		$Start.global_position, # El punto inicial en coordenadas globales
		$End.global_position, # El punto final en coordenadas globales
		true, # true para optimizar, falso sino
		2 # Bitmask de las layers posibles, en este caso solo la 2
	)
	# Y se grafica con una Line2D
	$Layer2Line2D.points = path2
	
	# Ambas layers
	var path3 := Navigation2DServer.map_get_path(
		get_world_2d().navigation_map, # El mapa
		$Start.global_position, # El punto inicial en coordenadas globales
		$End.global_position, # El punto final en coordenadas globales
		true, # true para optimizar, falso sino
		3 # Bitmask de las layers posibles, en este caso 1 y 2
	)
	# Y se grafica con una Line2D
	$BothLayersLine2D.points = path3
