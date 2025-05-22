extends Object
class_name Matrix

var c: int
var r: int
var arr : PackedFloat64Array = [] #problem at deler samme objekt alle instanser? reddit post

func _init(c: int, r: int) -> void:
	self.c = c
	self.r = r
	arr.resize(c*r)
	for i in range(arr.size()):
		arr[i] = 0.0

func set_arr(arr: Array) -> void:
	assert(self.arr.size() == arr.size())
	for i in range(arr.size()):
		self.arr[i] = arr[i]


static func add(m1: Matrix, m2: Matrix) -> Matrix:
	assert(m1.arr.size() == m2.arr.size())
	var result: Matrix = Matrix.new(m1.c, m1.r)
	for i in range(m1.arr.size()):
		result.arr[i] = m1.arr[i] + m2.arr[i]
	return result
	
