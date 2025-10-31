# VisualNovelTemplate2D
starting toolset for making a custom visual novel in Godot
<hr>

### Contents
- [Use Cases](#usecases)
- [Classes](#classes)
- [Functions](#functions)

<hr>
<a name="usecases" />

## Use Cases
Making a game for a __Game Jam__
Building __custom visual novel__ with minimal external code
Creating __short segments__ or visual novel elements for larger games

<hr>
<a name="classes" />

## Classes
__BaseMenu__ 
Creates a menu with centered buttons
_Node_:  VBoxContainer
_Signals_:  Buttons emit the `menu_pressed` signal and pass their button name as `String` when clicked

__Character__
Holds a set of images or expressions for a character
_Node_: Node2D
_Signals_: none

__StoryAct__
Holds and plays dialogues in the order specified, with a decision (optional) as the end
_Node_: Node2D
_Signals_: emits the `act_end` signal when all act events (dialogues & decision) are completed

__Dialogue__
Creates a dialogue with _only text_ 
_Node_: PanelContainer
_Signals_: emits the `dialogue_end` signal when clicked

__BoxDialogue__
Creates a dialogue with an _image next to text_ 
_Node_: PanelContainer
_Signals_: emits the `dialogue_end` signal when clicked

__Decision__
Creates a choice with two or more option buttons
_Node_: BoxContainer
_Signals_: emits the `decision_pressed` signal and passes two `String` arguments when a choice is clicked

__ScreenDialogue__ (under construction)
Creates a dialogue with an _image above text_ 
_Node_: PanelContainer
_Signals_: emits the `dialogue_end` signal when clicked

<hr>
<a name="functions" />


## Functions
 Click on the function to read more

__BaseMenu__ 
<details>
  <summary><code> set_menu_name(m_name: String) </code></summary>
Sets the name of the menu object
Accepts one `String` 
Returns nothing
</details>
<details>
  <summary><code> add_new_button(btn_name: String) </code></summary>
Adds a new button to the menu
The name of the button is displayed as the label of the button
The name is also emitted as an argument with the signal `menu_pressed`
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> remove_button(btn_name: String) </code></summary>
Removes the button that has the same name as passed string
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> list_buttons() -> Array[Node] </code></summary>
Returns a list of all buttons in that menu object
Accepts nothing
Returns `Array`
</details>

__Character__
<details>
  <summary><code> set_character_name(ch_name: String) </code></summary>
Sets the name of the character object
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> add_emotion_texture(emotion_name: String, image_path: String) </code></summary>
Creates a texture from provided image
The texture is saved under the specified name
Accepts two `Strings` - first string sets the name of the texture, second string is the path to the source image for the texture
Returns nothing
</details>
<details>
  <summary><code> get_emotion_texture(emotion_name: String) -> Texture2D </code></summary>
Returns the texture saved under the specified name
Returns a blank texture if no texture has been saved under the specified name
Accepts one `String`
Returns `Texture2D`
</details>

__StoryAct__
<details>
  <summary><code> set_act_characters(ch_array : Array[Character]) </code></summary>
Sets the character objects to use in a StoryAct object
StoryAct uses these character objects to assign images to dialogues
Accepts one `Array[Character]` 
Returns nothing
</details>
<details>
  <summary><code> set_dialogues(dg_data: Array) </code></summary>
Creates dialogues in the specified sequence
Accepts one `Array`
Returns nothing
</details>
<details>
  <summary><code> set_decision(decision_data: Dictionary) </code></summary>
Creates the decision for the StoryAct object
Each StoryAct object has one decision object
If decision is set, then the StoryAct ends after a choice is made, else it ends after the last dialogue in the sequence
Accepts one `Dictionary`
Returns nothing
</details>
<details>
  <summary><code> play_act() </code></summary>
Starts the dialogues in the sequence set with `set_dialogues(dg_data: Array)`
Accepts nothing
Returns nothing
</details>
<details>
  <summary><code> get_act_outcome() -> Array[String] </code></summary>
Returns the outcome of the StoryAct object's decision
Accepts nothing
Returns `Array[String]` - Array[0] is the decision name, Array[1] is the choice picked by player
</details>
<details>
  <summary><code> get_act_history() -> Array[String] </code></summary>
Returns the dialogues that have been completed by the player in that StoryAct object
Retains sequence in which dialogues were completed
Does not include the decision or its choice
Accepts nothing
Returns `Array[String]` - each string is a dialogue
</details>

__Dialogue__
<details>
  <summary><code> set_dialogue_data(text: String) </code></summary>
Sets the text for the dialogue object
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> get_dialogue_data() -> String </code></summary>
Returns the text that is displayed in that dialogue object
Accepts nothing
Returns `String`
</details>

__BoxDialogue__
<details>
  <summary><code> set_dialogue_data(text: String) </code></summary>
Sets the text for the BoxDialogue object
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> set_dialogue_speaker(img: Texture2D, sp_name: String) </code></summary>
Sets the speaker of the dialogue for the BoxDialogue object
Accepts one `Texture2D`, one `String` - texture is used to display the dialogue image, string is used to display the speaker name
Returns nothing
</details>
<details>
  <summary><code> get_dialogue_data() -> String </code></summary>
Returns the speaker name and dialogue text that is displayed in that BoxDialogue object
Accepts nothing
Returns `String`
</details>


__Decision__
<details>
  <summary><code> set_decision_name(decn_name: String) </code></summary>
Sets the name of the decision
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> add_choice(option: String) </code></summary>
Creates a button as one of the choices for that decision
The passed text is displayed as the option
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> remove_option(option_name: String) </code></summary>
Removes the specified option from the list of options for that decision
Accepts one `String`
Returns nothing
</details>
<details>
  <summary><code> list_options() -> Array[Node] </code></summary>
Returns a list of options found in that decision
Accepts nothing
Returns `Array`
</details>

