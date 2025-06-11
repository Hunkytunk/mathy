extends Node2D


@export var thicker_axis: bool = true

func _draw() -> void:
	draw_grid()
	draw_circle(Vector2.ZERO, 5, Color.DIM_GRAY)
	draw_line(Vector2.ZERO, get_parent().u_basis.get_col(0), Color.DIM_GRAY, 2.0)
	draw_line(Vector2.ZERO, get_parent().u_basis.get_col(1), Color.DIM_GRAY, 2.0)

func draw_grid():
	var screen_size_u: Vector2 = get_viewport_rect().size
	
	var size_u: Vector2 = Vector2(0, 0)
	var corners: Array[Vector2] = [Vector2(0, 0), Vector2(screen_size_u.x, 0), Vector2(0, screen_size_u.y), screen_size_u]
	
	for i in range(corners.size()):
		var corner_u = get_parent().u_basis_inv.mult_vec(corners[i])
		corner_u.x = ceil(abs(corner_u.x))
		corner_u.y = ceil(abs(corner_u.y))
		if corner_u.x > size_u.x:
			size_u.x = corner_u.x
		if corner_u.y > size_u.y:
			size_u.y = corner_u.y
	
	var pos = -size_u.x*get_parent().u_basis.get_col(0)
	draw_line(pos-size_u.y*get_parent().u_basis.get_col(1), pos+size_u.y*get_parent().u_basis.get_col(1), get_parent().color_weak, get_parent().line_thickness)
	for i in range(size_u.x*2):
		pos += get_parent().u_basis.get_col(0)
		if i == size_u.x-1 and thicker_axis:
			draw_line(pos-size_u.y*get_parent().u_basis.get_col(1), pos+size_u.y*get_parent().u_basis.get_col(1), Color(get_parent().color_weak, 0.9), get_parent().line_thickness*2)
			continue
		draw_line(pos-size_u.y*get_parent().u_basis.get_col(1), pos+size_u.y*get_parent().u_basis.get_col(1), get_parent().color_weak, get_parent().line_thickness)
	pos = -size_u.y*get_parent().u_basis.get_col(1)
	draw_line(pos-size_u.x*get_parent().u_basis.get_col(0), pos+size_u.x*get_parent().u_basis.get_col(0), get_parent().color_weak, get_parent().line_thickness)
	for i in range(size_u.y*2):
		pos += get_parent().u_basis.get_col(1)
		if i == size_u.y-1 and thicker_axis:
			draw_line(pos-size_u.x*get_parent().u_basis.get_col(0), pos+size_u.x*get_parent().u_basis.get_col(0), Color(get_parent().color_weak, 0.9), get_parent().line_thickness*2)
			continue
		draw_line(pos-size_u.x*get_parent().u_basis.get_col(0), pos+size_u.x*get_parent().u_basis.get_col(0), get_parent().color_weak, get_parent().line_thickness)
