extends ScrollContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var backbutton = Button.new()
	backbutton.text = "Back"
	add_child(backbutton)

func set_history(dialogue_history: Array[String]):
	if not dialogue_history.is_empty():
		get_node("VBoxContainer").queue_free()
		var newvbox = VBoxContainer.new()
		newvbox.set_name("VBoxContainer")
		for dg_item in dialogue_history:
			var temp_label = Label.new()
			temp_label.text = dg_item
			newvbox.add_child(temp_label)
		add_child(newvbox)
