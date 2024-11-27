extends Node2D


signal shoot()

@export var rotation_speed: int = 10.0
@export var weapon_offset: Vector2 = Vector2(-5, 5)
@export var position_change_speed: float = 10.0

var current_offset: Vector2 = Vector2(0, 0)


func _ready() -> void:
	$AnimationPlayer.play("RESET")
	
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
	var offset = weapon_offset
	
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
		
	
	current_offset = current_offset.lerp(offset, position_change_speed * delta)
	position = offset
