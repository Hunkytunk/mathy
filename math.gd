extends Object
class_name Matrix

var r: int
var c: int
var arr : PackedFloat64Array = [] #problem at deler samme objekt alle instanser? reddit post

func _init(r: int, c: int) -> void:
	self.r = r
	self.c = c
	arr.resize(r*c)
	for i in range(arr.size()):
		arr.append(0)

func set_matrix(arr: Array):
	assert(self.arr.size() == arr.size())
	for i in arr:
		self.arr[i] = arr[i]

static func add(m1: Matrix, m2: Matrix) -> Matrix:
	assert(m1.arr.size() == m2.arr.size())
	var result: Matrix = Matrix.new(m1.r, m1.c)
	for i in m1.arr:
		result.arr[i] = m1.arr[i] + m2.arr[i]
	return result
	
