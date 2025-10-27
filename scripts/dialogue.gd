class_name Dialogue

extends PanelContainer

var label: Label = Label.new()
signal dialogue_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_dialogue_input_map()
	gui_input.connect(handle_dialogue_click)
	add_child(label)
	setup_constants()

func setup_constants():
	size = Vector2(1020, 232)
	position = Vector2(-510, 46)

func set_dialogue_data(text: String):
	label.text = text

func get_dialogue_data() -> String:
	return label.text

func setup_dialogue_input_map():
	if not InputMap.has_action("next_dialogue"):
		InputMap.add_action("next_dialogue")
		var action = InputEventMouseButton.new()
		action.button_index = 1
		action.pressed = true
		InputMap.action_add_event("next_dialogue", action)
		action = InputEventScreenTouch.new()
		action.index = 1
		action.pressed = true
		InputMap.action_add_event("next_dialogue", action)

func handle_dialogue_click(event: InputEvent):
	if InputMap.action_has_event("next_dialogue", event):
		dialogue_end.emit()
		hide()
	pass
