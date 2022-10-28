extends Control

func _ready():
    pass

func _on_CreateRoom_pressed():
    print('Creating room...')

func _on_JoinRoom_pressed():
    print('Joining room...')

func _on_LineEdit_text_changed(new_text: String):
    if new_text.length() == 6:
        $JoinRoom.disabled = false
    else:
        $JoinRoom.disabled = true
