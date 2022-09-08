extends Node2D


func _ready() -> void:
	# Se configura el agente de navegación
	$Dummy/NavigationAgent2D.set_target_location($End.global_position) # Setear la posición objetivo
	# El agente toma en cuenta los obstáculos y computa una velocidad segura para esquivarlo
	$Dummy/NavigationAgent2D.connect("velocity_computed", self, "set_velocity") # Se conecta la señal
	# Se configura manualmente el obstáculo como agente en el mapa, es un fix rápido para un bug ya que
	# El obstáculo debería ser capaz de hacerlo por su cuenta
	Navigation2DServer.agent_set_map($Obstacle/NavigationObstacle2D.get_rid(), get_world_2d().navigation_map)
	# Otro fix es activar la estimación de radio aquí porque no estima correctamente sino
	$Obstacle/NavigationObstacle2D.estimate_radius = true
	# Por último, se mueve el obstáculo con un tween
	var tween := create_tween().set_loops().set_trans(Tween.TRANS_SINE) # Setear loop infinito
	tween.tween_property($Obstacle, "position:y", 496.0, 3) # Primero se mueve hacia abajo
	tween.tween_property($Obstacle, "position:y", 336.0, 3) # Y luego hacia arriba

func _physics_process(_delta: float) -> void:
	# Se obtiene el siguiente punto del path que debe recorrer
	var next = $Dummy/NavigationAgent2D.get_next_location()
	# Y se le entrega una velocidad deseada al agente para que compute la velocidad segura
	$Dummy/NavigationAgent2D.set_velocity($Dummy.global_position.direction_to(next) * 100)

func set_velocity(safe_velocity : Vector2) -> void:
	# Para mostrar como interactúa en varios casos, se teletransporta a la posición inicial al terminar
	if $Dummy/NavigationAgent2D.is_navigation_finished():
		reset()
		return
	# Si no ha terminado
	$Line2D.add_point($Dummy.global_position) # Se añade el punto actual a la línea
	$Dummy.move_and_slide(safe_velocity) # Y se mueve según la velocidad computada por el agente

func reset() -> void:
	# Esto se ejecuta cuando el agente llegó al punto final
	$Line2D.clear_points() # Se limpia la línea
	$Line2D.add_point($Start.global_position) # Se agrega el primer punto para dibujar otra línea
	$Dummy.set_deferred("global_position", $Start.global_position) # Y se mueve a la posición inicial
