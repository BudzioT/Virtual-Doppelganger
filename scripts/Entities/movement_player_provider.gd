extends MovementProvider

@export_placeholder("ui_left") var action_left: String
@export_placeholder("ui_right") var action_right: String
@export_placeholder("ui_up") var action_up: String
@export_placeholder("ui_down") var action_down: String

func _process(delta: float) -> void:
	super._process(delta)
	provider_dir = Input.get_vector(action_left, action_right, action_up, action_down)
