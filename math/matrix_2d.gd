extends Object
class_name  Matrix2D

var arr: PackedFloat64Array = []

func _init() -> void:
	arr.resize(4)
	for i in range(arr.size()):
		arr[i] = 0

func set_arr(new_arr: PackedFloat64Array) -> void:
	assert(arr.size() == new_arr.size())
	for i in range(arr.size()):
		arr[i] = new_arr[i]

func set_arr_vec(v1: Vector2, v2: Vector2) -> void:
	arr[0] = v1.x
	arr[1] = v1.y
	arr[2] = v2.x
	arr[3] = v2.y

func at(c: int, r: int) -> float:
	assert(0 <= c and c <= 1 and 0 <= r and r <= 1)
	var i = c*2+r
	return arr[i]
	
func at_c(c: int, r: int, val: float) -> void:
	assert(0 <= c and c <= 1 and 0 <= r and r <= 1)
	var i = c*2+r
	arr[i] = val

func at_v(c: int) -> Vector2:
	return Vector2(at(c, 0), at(c, 1))

func inverse() -> Matrix2D:
	var result: Matrix2D = Matrix2D.new()
	var fac: float = 1/(at(0,0)*at(1,1)-at(1,0)*at(0,1))
	result.at_c(0,0, fac*at(1,1))
	result.at_c(0,1, -fac*at(0,1))
	result.at_c(1,0, -fac*at(1,0))
	result.at_c(1,1, fac*at(0,0))
	return result

func print_mat() -> void:
	var result: String = ""
	for r in range(2):
		for c in range(2):
			result += str(at(c, r)) + " "
		if not r == 1:
			result += "\n"
	print(result)
	

static func add(m1: Matrix2D, m2: Matrix2D) -> Matrix2D:
	assert(m1.arr.size() == m2.arr.size())
	var result: Matrix2D = Matrix2D.new()
	for i in range(m1.arr.size()):
		result.arr[i] = m1.arr[i] + m2.arr[i]
	return result

func mult_vec(v: Vector2) -> Vector2:
	var result: Vector2 = Vector2(0,0)
	result.x = at(0,0)*v.x+at(1,0)*v.y
	result.y = at(0,1)*v.x+at(1,1)*v.y
	return result

static func mult_mat(m1: Matrix2D, m2: Matrix2D) -> Matrix2D:
	assert(m1.arr.size() == m2.arr.size())
	var result: Matrix2D = Matrix2D.new()
	for r in range(2):
		for c in range(2):
			var val: float = 0.0
			for i in range(2):
				val += m1.at(i, r) * m2.at(c, i)
			result.at_c(c, r, val)
	return result
