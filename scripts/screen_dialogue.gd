extends Dialogue

var image: Sprite2D = Sprite2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_box_image(image)
	add_child(image)

func set_dialogue_image(img: Texture2D):
	image.set_texture(img)

func setup_box_image(img_sprite: Sprite2D):
	img_sprite.set_centered(false)
	img_sprite.set_region_enabled(false)
	@warning_ignore("integer_division")
	img_sprite.set_region_rect(Rect2(0, 0, 1020/4, 232)) 
	pass
