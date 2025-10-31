extends Node2D

var screen_size : Vector2i
var all_characters : Array[Character]
var all_acts : Array[StoryAct]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_project_constants()
	# write check for if saves exist, make a "save" menu instance
	# write check if history exists, make a "history" menu
	setup_characters()
	create_acts()
	display_main_menu()
	print("hello world") # checkpoint

# set game size, resolution
func get_project_constants():
	screen_size = get_tree().root.get_size()

func handle_menu_actions(button_pressed: String):
	match button_pressed:
		"New Game":
			# play act1
			get_node("MainMenu").hide()
			all_acts[0].show()
			all_acts[0].play_act()
		"Load":
			pass
		"History":
			pass
		_:
			print("menu button pressed: "+ button_pressed)

func handle_story_act_ends(ended_act: StoryAct):
	if ended_act.get_act_outcome().is_empty():
		display_main_menu()
	else:
		var dec_data = ended_act.get_act_outcome() #[decision name, chosen path]
		match dec_data[0]:
			"wake or sleep":
				if dec_data[1] == "continue sleeping":
					all_acts[1].show()
					all_acts[1].play_act() # play act2
				else:
					all_acts[2].show()
					all_acts[2].play_act() # play act3
			"ask or nope":
				if dec_data[1] == "nope, i'm out":
					all_acts[3].show()
					all_acts[3].play_act() # play act4
				else:
					all_acts[4].show()
					all_acts[4].play_act() # play act5
			_:
				print("invalid decision from ended act: " + dec_data[0])
	pass

# hide all nodes except main menu
func display_main_menu():
	for x in get_children():
		if x is Node:
			x.hide()
	get_node("MainMenu").show()

func setup_characters():
	var mc = Character.new()
	mc.set_character_name("you")
	mc.add_emotion_texture("base", "res://media/placeholders/wikimedia-Cat-in-da-hat.jpg")
	all_characters.append(mc)
	var who = Character.new()
	who.set_character_name("Cat by Koryu")
	who.add_emotion_texture("base", "res://media/placeholders/wikimedia_Cat_by_Koryusai.jpg")
	all_characters.append(who)

func create_acts():
	# creating act1
	var act1 = StoryAct.new()
	#act1.set_act_characters([]) doesnt have any
	act1.set_dialogues([
		"you are dreaming of a peaceful landscape, with no one around to break the peace"
	])
	act1.set_decision({
		"wake or sleep":"name",
		"wake up": "choice",
		"continue sleeping": "choice"
	})
	act1.act_end.connect(handle_story_act_ends.bind(act1))
	all_acts.append(act1)
	add_child(act1)
	
	# creating act2
	var act2 = StoryAct.new()
	#act2.set_act_characters([]) doesnt have any
	act2.set_dialogues([
		"you cannot waste a dream so peaceful",
		"sweet dreams"
	])
	#act2.set_decision({}) this is an ending
	act2.act_end.connect(handle_story_act_ends.bind(act2))
	all_acts.append(act2)
	add_child(act2)
	
	# creating act3
	var act3 = StoryAct.new()
	act3.set_act_characters([all_characters.get(1)])
	act3.set_dialogues([
		"you wake up and stretch, then walk out onto the wall to greet the moon",
		"when a cat approaches the wall",
		{
			"name":"Cat by Koryu",
			"face":"base",
			"text":"Hey, you. You're finally awake"
		}
	])
	act3.set_decision({
		"ask or nope": "name",
		"question the cat": "choice",
		"nope, i'm out": "choice"
	})
	act3.act_end.connect(handle_story_act_ends.bind(act3))
	all_acts.append(act3)
	add_child(act3)
	
	# creating act4
	var act4 = StoryAct.new()
	#act4.set_act_characters([]) 
	act4.set_dialogues([
		"waking up was a mistake, better correct it right away",
		"good night"
	])
	#act4.set_decision({})
	act4.act_end.connect(handle_story_act_ends.bind(act4))
	all_acts.append(act4)
	add_child(act4)
	
	# creating act5
	var act5 = StoryAct.new()
	act5.set_act_characters(all_characters)
	act5.set_dialogues([
		{
			"name": "you",
			"face": "base",
			"text": "Who are you?"
		},
		{
			"name": "Cat by Koryu",
			"face": "base",
			"text": "I am Cat by Koryusai, who are you?"
		},
		{
			"name": "you",
			"face": "base",
			"text": "I am Cat in da hat"
		},
		"this is the end of this story"
	])
	#act5.set_decision({})
	act5.act_end.connect(handle_story_act_ends.bind(act5))
	all_acts.append(act5)
	add_child(act5)
	
	# creating act
	#var act = StoryAct.new()
	#act.set_act_characters([])
	#act.set_dialogues([])
	#act.set_decision({})
	#act.act_end.connect(handle_story_act_ends.bind(act))
	#all_acts.append()
	#add_child()
