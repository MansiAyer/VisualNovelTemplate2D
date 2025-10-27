extends BaseMenu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"New Game".pressed.connect(handle_button_press.bind("New Game"))
	$"Load".pressed.connect(handle_button_press.bind("Load"))
	$"History".pressed.connect(handle_button_press.bind("History"))
