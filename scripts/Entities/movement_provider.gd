extends Node
class_name MovementProvider

@export_node_path("CharacterBody2D") var character_node
@onready var character: CharacterBody2D = get_node(character_node)

@export var enabled: bool = true
var provider_dir: Vector2 = Vector2(0, 0)


func _process(_delta: float) -> void:
	if character:
		if enabled:
			character.dir = provider_dir
		else:
			character.dir = 0.0
