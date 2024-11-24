extends CharacterBody2D

@export_group("Movement")
@export var max_speed: float = 120.0
@export var acceleration: float = 512.0
@export var deceleration: float = 1024.0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var animation = $AnimationPlayer

var dir: Vector2 = Vector2(0, 0)
var target_speed: float = 0.0
var target_acceleration: float = 0.0


func _process(_delta: float) -> void:
	if dir.x < 0.0:
		sprite.flip_h = true
	elif dir.x > 0.0:
		sprite.flip_h = false
	
	if target_speed != 0.0:
		animation.play("Walk")
	else:
		animation.play("Idle")

func _physics_process(delta: float) -> void:
	if dir.length() > 0:
		dir = dir.normalized()
		target_speed = max_speed
		target_acceleration = acceleration
	else:
		target_speed = 0.0
		target_acceleration = deceleration
	
	var target_velocity = dir * target_speed
	
	if target_velocity.length() > 0:
		velocity = velocity.move_toward(target_velocity, target_acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	move_and_slide()
