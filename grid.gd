extends Node2D

@export var line_thickness: int = 2
@export var thicker_axis: bool = true
@export_group("Origo")
@export var center_origo: bool = true
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D
var color = Color.AQUAMARINE
var color_weak = Color(color, 0.2)

var rotation_matrix = Matrix2D.new()
func _ready() -> void:
	var theta = PI/(36*6)
	rotation_matrix.set_arr_vec(Vector2(cos(theta), sin(theta)), Vector2(-sin(theta), cos(theta)))
	u_basis.set_arr_vec(Vector2(20, 0), Vector2(0, -20))
	u_basis_inv = u_basis.inverse()
	if center_origo:
		position = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))


func _process(_delta):
	var c1 = u_basis.get_col(0)
	c1 = rotation_matrix.mult_vec(c1)
	u_basis.set_arr_vec(c1, u_basis.get_col(1))
	u_basis_inv = u_basis.inverse()
	queue_redraw()

func _draw() -> void:
	draw_grid()
	draw_circle(Vector2.ZERO, 5, Color.DIM_GRAY)
	draw_line(Vector2.ZERO, u_basis.get_col(0), Color.DIM_GRAY, 2.0)
	draw_line(Vector2.ZERO, u_basis.get_col(1), Color.DIM_GRAY, 2.0)

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
	draw_line(pos-size_u.y*u_basis.get_col(1), pos+size_u.y*u_basis.get_col(1), color_weak, line_thickness)
	for i in range(size_u.x*2):
		pos += u_basis.get_col(0)
		if i == size_u.x-1 and thicker_axis:
			draw_line(pos-size_u.y*u_basis.get_col(1), pos+size_u.y*u_basis.get_col(1), Color(color_weak, 0.9), line_thickness*2)
			continue
		draw_line(pos-size_u.y*u_basis.get_col(1), pos+size_u.y*u_basis.get_col(1), color_weak, line_thickness)
	pos = -size_u.y*u_basis.get_col(1)
	draw_line(pos-size_u.x*u_basis.get_col(0), pos+size_u.x*u_basis.get_col(0), color_weak, line_thickness)
	for i in range(size_u.y*2):
		pos += u_basis.get_col(1)
		if i == size_u.y-1 and thicker_axis:
			draw_line(pos-size_u.x*u_basis.get_col(0), pos+size_u.x*u_basis.get_col(0), Color(color_weak, 0.9), line_thickness*2)
			continue
		draw_line(pos-size_u.x*u_basis.get_col(0), pos+size_u.x*u_basis.get_col(0), color_weak, line_thickness)
