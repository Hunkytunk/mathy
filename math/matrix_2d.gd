extends Object
class_name  Matrix2D

var arr: PackedFloat64Array = []

func _init() -> void:
	arr.resize(4)
	for i in range(arr.size()):
		arr[i] = 0

func set_arr(arr: PackedFloat64Array):
	assert(self.arr.size() == arr.size())
	for i in range(self.arr.size()):
		self.arr[i] = arr[i]

func at(c: int, r: int) -> float:
	assert(0 <= c and c <= 1 and 0 <= r and r <= 1)
	var i = c*2+r
	return arr[i]

func print_matrix():
	var result: String = ""
	for r in range(2):
		for c in range(2):
			result += str(at(c, r)) + " "
		result += "\n"
	print(result)
	

static func add(m1: Matrix2D, m2: Matrix2D) -> Matrix2D:
	assert(m1.arr.size() == m2.arr.size())
	var result: Matrix2D = Matrix2D.new()
	for i in range(m1.arr.size()):
		result.arr[i] = m1.arr[i] + m2.arr[i]
	return result
