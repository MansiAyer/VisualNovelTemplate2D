extends HBoxContainer

signal close_history

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var backbutton = Button.new()
	backbutton.text = "Back"
	backbutton.pressed.connect(handle_back_pressed)
	#backbutton.position = size/2 does not work for child controls
	add_child(backbutton)

func set_history(dialogue_history: Array[String]):
	if not dialogue_history.is_empty():
		get_node("VBoxContainer").queue_free()
		var newvbox = VBoxContainer.new()
		newvbox.set_name("VBoxContainer")
		newvbox.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		newvbox.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		newvbox.alignment = BoxContainer.ALIGNMENT_CENTER
		newvbox.custom_minimum_size = Vector2(800, 296)
		for dg_item in dialogue_history:
			var temp_label = Label.new()
			temp_label.text = dg_item
			temp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			newvbox.add_child(temp_label)
		add_child(newvbox)

func handle_back_pressed():
	hide()
	close_history.emit() # in main this signal connects to display_main_menu()
