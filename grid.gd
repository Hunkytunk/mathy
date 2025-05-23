extends Node2D

@export var pixel_per_unit: int = 20
@export var line_thickness: int = 2
@export_group("Origo")
@export var center_origo: bool = true
@export var origo: Vector2
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D
var color = Color.AQUAMARINE
var color_weak = Color(color, 0.2)

func _ready() -> void:
	u_basis.set_arr_vec(Vector2(2, 2), Vector2(0, -2))
	u_basis_inv = u_basis.inverse()
	if center_origo:
		origo = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))

func global_to_u(point: Vector2) -> Vector2:
	var op = (point-origo)/pixel_per_unit
	return u_basis_inv.mult_vec(op)
	
func u_to_px(point: Vector2) -> Vector2:
	return origo+point*pixel_per_unit
	
func u_to_global(point: Vector2) -> Vector2:
	var op_u = u_basis.mult_vec(point)
	return u_to_px(op_u)


func _draw() -> void:
	draw_circle(origo, 5, color)
	draw_line(origo, u_to_px(u_basis.get_col(0)), color, 2.0)
	draw_line(origo, u_to_px(u_basis.get_col(1)), color, 2.0)
	draw_grid()

func draw_grid():
	var screen_size_u: Vector2 = get_viewport_rect().size/pixel_per_unit
	
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
	
	#These are dumb, fix
	size_u1 = 100
	size_u2 = 100
	var pos = -size_u1*u_basis.get_col(0)
	draw_line(u_to_px(pos-size_u2*u_basis.get_col(1)), u_to_px(pos+size_u2*u_basis.get_col(1)), color_weak, line_thickness)
	for i in range(size_u1*2-1):
		pos += u_basis.get_col(0)
		draw_line(u_to_px(pos-size_u2*u_basis.get_col(1)), u_to_px(pos+size_u2*u_basis.get_col(1)), color_weak, line_thickness)
	pos = -size_u2*u_basis.get_col(1)
	draw_line(u_to_px(pos-size_u1*u_basis.get_col(1)), u_to_px(pos+size_u1*u_basis.get_col(1)), color_weak, line_thickness)
	for i in range(size_u2*2-1):
		pos += u_basis.get_col(1)
		draw_line(u_to_px(pos-size_u1*u_basis.get_col(0)), u_to_px(pos+size_u1*u_basis.get_col(0)), color_weak, line_thickness)

	print(screen_size_u)
	print(size_u1)
	print(size_u2)
