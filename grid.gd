extends Node2D

@export_category("Grid")
enum Styles {SQUARE, RECTANGLE, POLAR}
@export var Style: Styles
const UNIT: Vector2 = Vector2(1, 1)
const REC_COUNT: Vector2 = Vector2(20, 14)
