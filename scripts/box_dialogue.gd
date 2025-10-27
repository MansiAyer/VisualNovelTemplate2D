class_name BoxDialogue

extends Dialogue

var image: Sprite2D = Sprite2D.new()
var speaker: Label = Label.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_dialogue_input_map()
	gui_input.connect(handle_dialogue_click)
	setup_box_image(image)
	add_child(image)
	add_child(speaker)
	add_child(label)
	setup_constants()


func set_dialogue_speaker(img: Texture2D, sp_name: String):
	image.set_texture(img)
	speaker.set_text(sp_name)

func setup_box_image(img_sprite: Sprite2D):
	img_sprite.set_centered(true)
	img_sprite.set_region_enabled(true)
	@warning_ignore("integer_division")
	img_sprite.set_region_rect(Rect2(0, 0, 1020/4, 232)) 
	img_sprite.position = img_sprite.region_rect.size/2

func get_dialogue_data() -> String:
	return speaker.text + super.get_dialogue_data()
