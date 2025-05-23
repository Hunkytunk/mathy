extends Node2D

#const RECT = Vector2(20, 20)
#var RECT_SIZE : Vector2
@export var pixel_per_unit: int = 20
@export var line_thickness: int = 2
@export_group("Origo")
@export var center_origo: bool = true
@export var origo: Vector2
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D

func _ready() -> void:
	u_basis.set_arr_vec(Vector2(1,0), Vector2(0,-1))
	u_basis_inv = u_basis.inverse()
	if center_origo:
		origo = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))

func global_to_u(point: Vector2) -> Vector2:
	var op = (point-origo)/pixel_per_unit
	return u_basis_inv.mult_vec(op)
	
func u_to_global(point: Vector2) -> Vector2:
	var op_u = u_basis.mult_vec(point)
	return op_u*pixel_per_unit+origo

func _draw() -> void:
	draw_circle(origo, 5, Color.AQUAMARINE)
	draw_line(origo, u_to_global(u_basis.get_col(0)), Color.AQUAMARINE, 2.0)
	draw_line(origo, u_to_global(u_basis.get_col(1)), Color.AQUAMARINE, 2.0)
	draw_grid()

func draw_grid():
	var screen_size_u: Vector2 = get_viewport_rect().size/pixel_per_unit
	screen_size_u = Vector2(screen_size_u.x, screen_size_u.y)
	
	var size_u1: int
	if u_basis.at(0, 0) == 0:
		size_u1 = abs(ceil(screen_size_u.y/u_basis.at(0, 1)))
	elif u_basis.at(0, 1) == 0:
		size_u1 = abs(ceil(screen_size_u.x/u_basis.at(0, 0)))
	else:
		size_u1 = min(abs(ceil(screen_size_u.x/u_basis.at(0, 0))), abs(ceil(screen_size_u.y/u_basis.at(0, 1))))
		
	var size_u2: int
	if u_basis.at(1, 0) == 0:
		size_u2 = abs(ceil(screen_size_u.y/u_basis.at(1, 1)))
	elif u_basis.at(1, 1) == 0:
		size_u2 = abs(ceil(screen_size_u.x/u_basis.at(1, 0)))
	else:
		size_u2 = min(abs(ceil(screen_size_u.x/u_basis.at(1, 0))), abs(ceil(screen_size_u.y/u_basis.at(1, 1))))
	
	var u = -size_u1*u_basis.get_col(0)
	for i in range(size_u1*2-1):
		pass
	print(screen_size_u)
	print(size_u1)
	print(size_u2)

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
