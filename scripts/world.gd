extends Node


@onready var main_window: Window = get_window()
@onready var sub_window: Window = $Window
@export var player_size: Vector2i = Vector2i(32, 32)


func _ready():
	# Share the same world as main window
	sub_window.world_2d = main_window.world_2d
	$Window.world_2d = main_window.world_2d
	
	ProjectSettings.set_setting("display/window/per_pixel_transparency/allowed", true)
	main_window.borderless = true
	main_window.unresizable = true
	main_window.always_on_top = true
	main_window.gui_embed_subwindows = false
	main_window.transparent = true
	main_window.transparent_bg = true
	
	main_window.min_size = player_size
	main_window.size = main_window.min_size
	
