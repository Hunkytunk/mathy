extends Node2D

#const RECT = Vector2(20, 20)
#var RECT_SIZE : Vector2
@export var pixel_per_unit: int
@export_group("Origo")
@export var center_origo : bool
@export var origo : Vector2
var u = [Vector2(1,0), Vector2(0,1)]


func _ready() -> void:
	if center_origo:
		origo = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))
	print(origo)
	var matrix = Matrix.new()
	print(matrix.mordi)

func global_to_u(point: Vector2):
	var op = (point-origo)/pixel_per_unit
	



#func _ready() -> void:
	#origo = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))
	#var rect_size_x = int(get_viewport_rect().size.x/RECT.x)
	#RECT_SIZE = Vector2(rect_size_x, rect_size_x)
#
#func _process(_delta: float) -> void:
	#if Engine.is_editor_hint():
		#queue_redraw()
#
#func _draw() -> void:
	#draw_grid()
	#points = 1000
	#x_start = 0
	#x_end = 600
	#dx = point/(x_end-x_start)
	#for i in range(points):
		#pass
#
#func draw_grid():
	#var x_draw = 0
	#var y_draw = 0
	#draw_line(Vector2(origo.x, 0), Vector2(origo.x, get_viewport_rect().size.y), Color.WEB_GRAY, 4.0)
	#draw_line(Vector2(0, origo.y), Vector2(get_viewport_rect().size.x, origo.y+y_draw), Color.WEB_GRAY, 4.0)
	#for i in range(RECT.x):
		#x_draw += RECT_SIZE.x
		#draw_line(Vector2(origo.x+x_draw, 0), Vector2(origo.x+x_draw, get_viewport_rect().size.y), Color.WEB_GRAY, 2.0)
		#draw_line(Vector2(origo.x-x_draw, 0), Vector2(origo.x-x_draw, get_viewport_rect().size.y), Color.WEB_GRAY, 2.0)
		#y_draw += RECT_SIZE.y
		#draw_line(Vector2(0, origo.y+y_draw), Vector2(get_viewport_rect().size.x, origo.y+y_draw), Color.WEB_GRAY, 2.0)
		#draw_line(Vector2(0, origo.y-y_draw), Vector2(get_viewport_rect().size.x, origo.y-y_draw), Color.WEB_GRAY, 2.0)
	#draw_circle(origo, 6.0, Color.WEB_GRAY)
#
#func f(x):
	#return x**2
