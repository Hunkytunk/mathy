extends Node2D

@export var line_thickness: int = 2
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D
var color = Color.AQUAMARINE
var color_weak = Color(color, 0.2)

func queue_all_redraw():
	var arr = get_children()
	for i in range(arr.size()):
		arr[i].queue_redraw()

func _process(_delta):
	queue_all_redraw()
