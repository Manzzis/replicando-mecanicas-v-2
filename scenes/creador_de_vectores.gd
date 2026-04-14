extends Control

signal vector_created(Vector2)

@export var max_length := 100

var touch_down = false

var start_position := Vector2.ZERO
var end_position := Vector2.ZERO
var drawing : bool = false
var vector := Vector2.ZERO


func _ready():
	set_size(Vector2(720, 480))


func _draw():
	draw_line(
	start_position -global_position,
	start_position-global_position + vector ,
	Color.BLUE, 4)
	
	draw_line(
	start_position - global_position,
	 end_position - global_position + vector,
	Color.RED, 6)


func _reset():
	start_position = Vector2.ZERO
	end_position = Vector2.ZERO
	vector = Vector2.ZERO
	
	queue_redraw()


func _input(event) -> void:
	if not touch_down:
		return
		
	if event.is_action_released("clickizq"):
		touch_down = false
		print("nuevo vecto:", vector)
		emit_signal("vector_created", vector)
		_reset()
		
	if event is InputEventMouseMotion:
		end_position = event.position
		vector = -(end_position - start_position).limit_length(max_length)
		queue_redraw()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("clickizq"):
		touch_down = true
		start_position = get_local_mouse_position()
		end_position = start_position
		vector = Vector2.ZERO
