extends Node2D

var plots = []

func _draw():
	for i in range(plots.size()):
		if (plots[i].size() < 2):
			print("Not enough points. Requires 2 or more points")
			plots.remove_at(i)
			continue
		for j in range(1, plots[i].size()):
			draw_line(get_parent().u_basis.mult_vec(plots[i][j-1]), get_parent().u_basis.mult_vec(plots[i][j]), get_parent().color, get_parent().line_thickness)



func _ready():
	var result = []
	var i = 0
	while i < PI*2:
		result.append(Vector2(sin(4*i)*cos(i)*8, sin(4*i)*sin(i)*8))
		i += 0.01
	plots.append(result)
