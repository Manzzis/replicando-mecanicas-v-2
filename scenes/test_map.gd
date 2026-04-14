extends Node2D

var vectorCreator = load("res://scenes/creador_de_vectores.tscn")



func _on_creador_de_vectores_vector_created(Force: Vector2) -> void:
	#if $player.global_position.distance_to($objeto.global_position) <= 50:
	$objeto.apply_impulse(Vector2.ZERO, Force * 2000)
	$objeto.linear_velocity = Force * 5
	var dir = Force.normalized()
	$player.new_dir.x = dir.x * 2000
	$player.new_dir.y = Force.y * 5
