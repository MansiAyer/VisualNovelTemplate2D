class_name StoryAct

extends Node2D

@export var act_characters : Array[Character]
@export var act_decision : Decision
@export var act_decision_outcome : Array[String] = []
@export var act_dialogues : Array[Dialogue]
@export var act_history : Array[String]
signal act_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_constants()

func setup_constants():
	#position = Vector2(-510, 46)
	position = Vector2.ZERO

func set_act_characters(ch_array : Array[Character]):
	for ch_x in ch_array:
		var ch_x_copy = ch_x.duplicate()
		act_characters.append(ch_x_copy)
		add_child(ch_x_copy)

func set_dialogues(dg_data: Array):
	var tempdg
	# expected format
	# ["ebebeb", { "name": "cat by koryu", "face": "base", "text":"wameme" }, "eg"]
	for data in dg_data:
		if data is String: # no character specified, narrator dialogue
			tempdg = Dialogue.new()
			tempdg.set_dialogue_data(data)
			act_dialogues.append(tempdg)
		elif data is Dictionary:
			tempdg = BoxDialogue.new()
			tempdg.set_dialogue_data(data["text"])
			var tempface 
			var tempname
			if get_node(data["name"]) is Node:
				tempface = get_node(data["name"]).get_emotion_texture(data["face"])
				tempname = get_node(data["name"]).character_name
			# slower but easier to understand alt method is
			#for x in act_characters:
				#if x.name == data["name"]:
					#tempface = x.get_emotion_texture(data["face"])
			tempdg.set_dialogue_speaker(tempface, tempname)
			act_dialogues.append(tempdg)
	for x in range(act_dialogues.size()):
		act_dialogues[x].dialogue_end.connect(handle_dialogue_end.bind(x))
		add_child(act_dialogues[x])
	# end of set_dialogues

func set_decision(decision_data: Dictionary):
	# expected format of decision_data
	# {
	#  "decision name": "name",
	#  "decision option": "choice",
	#  "decision option blah": "choice",
	# }
	# use the actual data as the key and use value as the identifier for the key
	# since options tend to be different [exceptions: horror vns] 
	act_decision = Decision.new()
	for data in decision_data:
		match decision_data[data]:
			"name":
				act_decision.set_decision_name(data)
			"choice":
				act_decision.add_choice(data)
			_:
				print("invalid decision passed to act: " + decision_data[data])
				pass # idk
	act_decision.decision_pressed.connect(handle_decision_press)
	add_child(act_decision)
	act_decision.hide()

func play_act():
	act_history = []
	for x in range(act_dialogues.size()):
		if x == 0:
			act_dialogues[x].show()
		else:
			act_dialogues[x].hide()
	show()


func handle_dialogue_end(dg_index: int):
	# add ended dialogue to history
	act_history.append(act_dialogues[dg_index].get_dialogue_data())
	# the ended dialogue hides itself, so show next dialogue
	if not dg_index+1 == act_dialogues.size():
		act_dialogues[dg_index+1].show()
	else:
		if act_decision is Decision:
			act_decision.show()
		else:
			act_end.emit() # if no decision is created, that means this is an ending act

func handle_decision_press(dec_name: String, chosen_opt: String):
	act_decision_outcome.clear()
	act_decision_outcome.append(dec_name)
	act_decision_outcome.append(chosen_opt)
	act_end.emit()
	# decision hides itself after a choice is made

func get_act_outcome() -> Array[String]:
	if act_decision_outcome is Array:
		return act_decision_outcome
	else:
		return []

func get_act_history() -> Array[String]:
	return act_history
