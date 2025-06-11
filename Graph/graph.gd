extends Node2D

@export var line_thickness: int = 2
@export_group("Origo")
@export var center_origo: bool = true
var u_basis: Matrix2D = Matrix2D.new()
var u_basis_inv: Matrix2D
var color = Color.AQUAMARINE
var color_weak = Color(color, 0.2)

func _ready() -> void:
	u_basis.set_arr_vec(Vector2(20, 0), Vector2(0, -20))
	u_basis_inv = u_basis.inverse()
	if center_origo:
		position = Vector2(floor(get_viewport_rect().size.x/2), floor(get_viewport_rect().size.y/2))

func queue_all_redraw():
	var arr = get_children()
	for i in range(arr.size()):
		arr[i].queue_redraw()

func _process(_delta):
	queue_all_redraw()
