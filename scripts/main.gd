extends Node


@export var player_size: Vector2i = Vector2(32, 32)
@export_range(0, 19) var player_visibility_layer: int = 1
@export_range(0, 19) var world_visibility_layer: int = 0
@export_node_path("Camera2D") var main_camera_node: NodePath
@export var view_window: PackedScene

var world_offset: Vector2i = Vector2i.ZERO

@onready var main_camera: Camera2D = get_node(main_camera_node)
@onready var main_window: Window = get_window()
@onready var main_screen: int = main_window.current_screen
@onready var main_screen_rect: Rect2i = DisplayServer.screen_get_usable_rect(main_screen)


func _ready() -> void:
	ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed", true)
	
	main_window.borderless = true
	main_window.unresizable = true
	main_window.always_on_top = true
	main_window.gui_embed_subwindows = false
	
	main_window.transparent = true
	main_window.transparent_bg = true
	
	main_window.min_size = player_size * Vector2i(main_camera.zoom)
	main_window.size = main_window.min_size
	
	main_window.set_canvas_cull_mask_bit(player_visibility_layer, true)
	main_window.set_canvas_cull_mask_bit(world_visibility_layer, false)
	
	world_offset = Vector2i(main_screen_rect.size.x / 2, main_screen_rect.size.y)
	
func _process(delta: float) -> void:
	main_window.position = get_window_pos()
	
func get_window_pos() -> Vector2i:
	"""Get position of window"""
	return (Vector2i(main_camera.global_position + main_camera.offset) - player_size / 2) * Vector2i(main_camera.zoom) + world_offset
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		create_view_window()
		
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
func create_view_window():
	"""Create a window that improves visibility"""
	var new_window: Window = view_window.instantiate()
	
	new_window.world_2d = main_window.world_2d
	new_window.world_3d = main_window.world_3d
	new_window.world_offset = world_offset
	
	new_window.set_canvas_cull_mask_bit(player_visibility_layer, false)
	new_window.set_canvas_cull_mask_bit(world_visibility_layer, true)
	add_child(new_window)
