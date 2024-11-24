extends Window


@onready var camera: Camera2D = $Camera2D

var world_offset: Vector2i = Vector2i.ZERO
var last_position: Vector2i = Vector2i.ZERO
var velocity: Vector2i = Vector2i.ZERO
var focused: bool = false


func _ready() -> void:
	camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	
	transient = true
	close_requested.connect(queue_free)
	
func _process(delta: float) -> void:
	velocity = position - last_position
	last_position = position
	camera.position = get_camera_pos()
	
func get_camera_pos() -> Vector2i:
	return (position + velocity - world_offset) / Vector2i(camera.zoom)
