class_name BaseMenu

extends VBoxContainer

signal menu_pressed(button_name: String)
@export var menu_name : String = "defaultMenu"
@export var menu_background : Sprite2D = Sprite2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_name = get_name() as String

func set_menu_background(bg_image_path: String):
	menu_background.set_texture(load(bg_image_path) as Texture2D)
	add_child(menu_background)
	menu_background.set_position(Vector2.ZERO)


func set_menu_name(m_name: String):
	menu_name = m_name
	set_name(menu_name)

func handle_button_press(btn_name: String):
	menu_pressed.emit(btn_name)

func add_new_button(btn_name: String):
	var new_button = Button.new()
	new_button.name = btn_name
	new_button.text = btn_name
	new_button.pressed.connect(handle_button_press.bind(new_button.name))
	add_child(new_button)

func remove_button(btn_name: String):
	if get_node(btn_name) is Node:
		get_node(btn_name).queue_free()

func list_buttons() -> Array[Node]:
	return get_children()
	# is this needed?
