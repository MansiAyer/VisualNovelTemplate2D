class_name Character

extends Node2D

@export var character_name : String = "default"
@export var emotion_textures : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_name(character_name)

func set_character_name(ch_name: String):
	character_name = ch_name
	set_name(character_name)

func add_emotion_texture(emotion_name: String, image_path: String):
	var temp_texture = Texture2D.new()
	temp_texture = load(image_path) as Texture2D
	emotion_textures[emotion_name] = temp_texture

func get_emotion_texture(emotion_name: String) -> Texture2D:
	if emotion_textures[emotion_name] is Texture2D:
		return emotion_textures[emotion_name]
	else :
		return Texture2D.new()
