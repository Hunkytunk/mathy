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
