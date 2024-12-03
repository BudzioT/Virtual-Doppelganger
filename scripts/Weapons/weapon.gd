extends Node2D


signal shoot()

@export var rotation_speed: int = 10
@export var weapon_offset: Vector2 = Vector2(-5, 5)
@export var position_change_speed: float = 10.0

var current_offset: Vector2 = Vector2(0, 0)
var target_offset: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	target_offset = weapon_offset
	current_offset = weapon_offset
	
func _physics_process(delta: float) -> void:
	var direction = get_global_mouse_position() - global_position
	var target_angle = direction.angle()
	
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
	
	update_weapon_pos(direction, delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if $Timer.is_stopped():
			$Timer.start()
			$AnimationPlayer.play("Shoot")
			shoot.emit()
		
func update_weapon_pos(direction: Vector2, delta: float):
	var new_target_offset = weapon_offset
	
	# Horizontal flip
	if direction.x < 0:
		new_target_offset.x = -abs(weapon_offset.x)
		scale.y = -abs(scale.y)
	else:
		new_target_offset.x = abs(weapon_offset.x)
		scale.y = abs(scale.y)
	
	# Vertical positioning
	if direction.y < 0:
		new_target_offset.y = -abs(weapon_offset.y)
	else:
		new_target_offset.y = abs(weapon_offset.y)
	
	"""
	if direction.x < 0:
		offset.x = -abs(weapon_offset.x)
		scale.y = -abs(scale.y)
	else:
		offset.x = abs(weapon_offset.x)
		scale.y = abs(scale.y)
		
	if direction.y < 0:
		offset.y = -abs(offset.y)
	else:
		offset.y = abs(offset.y)
	"""
		
	
	target_offset = new_target_offset
	current_offset = current_offset.lerp(target_offset, position_change_speed * delta)
	
	# Set the position to the interpolated offset
	position = current_offset
