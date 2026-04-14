extends Node2D

var vectorCreator = load("res://scenes/creador_de_vectores.tscn")





func _on_creador_de_vectores_vector_created(Force: Vector2) -> void:
	#if $player.global_position.distance_to($objeto.global_position) <= 50:
	var force_limit = Force.limit_length(100)
	$objeto.apply_impulse(Vector2.ZERO, force_limit * 2000)
	$objeto.linear_velocity = Force * 5
	$player.new_dir.y = -force_limit.y * 5
	$player.new_dir.x = -force_limit.x * 20
