class_name Decision

extends BoxContainer

signal  decision_pressed(name: String, option: String)

var decision_name: String = "default"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_name(decision_name)
	set_vertical(true) 
	setup_constants()

func setup_constants():
	#set_anchors_preset(Control.PRESET_CENTER)
	position = size*-1/2

func set_decision_name(decn_name: String):
	decision_name = decn_name
	set_name(decision_name)

func handle_button_press(option_name: String):
	decision_pressed.emit(decision_name, option_name)
	hide()

func add_choice(option: String):
	var new_button = Button.new()
	new_button.name = option
	new_button.text = option
	new_button.pressed.connect(handle_button_press.bind(new_button.name))
	add_child(new_button)

func remove_option(option_name: String):
	if get_node(option_name) is Node:
		get_node(option_name).queue_free()

func list_options() -> Array[Node]:
	return get_children()
	# is this needed?
