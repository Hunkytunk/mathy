extends Node2D


var rotation_matrix = Matrix2D.new()

func _ready():
	var theta = PI/(36*6)
	rotation_matrix.set_arr_vec(Vector2(cos(theta), sin(theta)), Vector2(-sin(theta), cos(theta)))

func _process(_delta):
	var c1 = get_parent().u_basis.get_col(0)
	c1 = rotation_matrix.mult_vec(c1)
	c1 = c1 + 0.2*c1/c1.length()
	get_parent().u_basis.set_arr_vec(c1, get_parent().u_basis.get_col(1))
	get_parent().u_basis_inv = get_parent().u_basis.inverse()
