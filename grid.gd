extends Node2D

@export var line_thickness: int = 2
@export_group("Origo")
@export var center_origo: bool = true
@export var origo: Vector2
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D
var color = Color.AQUAMARINE
var color_weak = Color(color, 0.2)

func _ready() -> void:
	u_basis.set_arr_vec(Vector2(20, 0), Vector2(0, -20))
	u_basis_inv = u_basis.inverse()
	if center_origo:
		origo = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))

func global_to_u(point: Vector2) -> Vector2:
	var op = point-origo
	return u_basis_inv.mult_vec(op)
	
func u_to_px(point: Vector2) -> Vector2:
	return origo+point
	
func u_to_global(point: Vector2) -> Vector2:
	var op_u = u_basis.mult_vec(point)
	return u_to_px(op_u)


func _draw() -> void:
	draw_circle(origo, 5, color)
	draw_line(origo, u_to_px(u_basis.get_col(0)), color, 2.0)
	draw_line(origo, u_to_px(u_basis.get_col(1)), color, 2.0)
	draw_grid()

func draw_grid():
	var screen_size_u: Vector2 = get_viewport_rect().size
	
	var size_u: Vector2 = Vector2(0, 0)
	var corners: Array[Vector2] = [Vector2(0, 0), Vector2(screen_size_u.x, 0), Vector2(0, screen_size_u.y), screen_size_u]
	
	for i in range(corners.size()):
		var corner_u = u_basis_inv.mult_vec(corners[i])
		corner_u.x = ceil(abs(corner_u.x))
		corner_u.y = ceil(abs(corner_u.y))
		if corner_u.x > size_u.x:
			size_u.x = corner_u.x
		if corner_u.y > size_u.y:
			size_u.y = corner_u.y
	
	var pos = -size_u.x*u_basis.get_col(0)
	#draw_line(u_to_px(pos-size_u.y*u_basis.get_col(1)), u_to_px(pos+size_u.y*u_basis.get_col(1)), color_weak, line_thickness)
	for i in range(size_u.x*2-1):
		pos += u_basis.get_col(0)
		draw_line(u_to_px(pos-size_u.y*u_basis.get_col(1)), u_to_px(pos+size_u.y*u_basis.get_col(1)), color_weak, line_thickness)
	pos = -size_u.y*u_basis.get_col(1)
	#draw_line(u_to_px(pos-size_u.x*u_basis.get_col(1)), u_to_px(pos+size_u.x*u_basis.get_col(1)), color_weak, line_thickness)
	for i in range(size_u.y*2-1):
		pos += u_basis.get_col(1)
		draw_line(u_to_px(pos-size_u.x*u_basis.get_col(0)), u_to_px(pos+size_u.x*u_basis.get_col(0)), color_weak, line_thickness)
#
	print(screen_size_u)
	print(size_u.x)
	print(size_u.y)
