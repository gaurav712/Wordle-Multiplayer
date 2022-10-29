extends Control

const utils = preload("res://scripts/utils.gd")

var UUID: String = ''
var db_ref: FirebaseDatabaseReference

func _ready():
    Firebase.Auth.connect("signup_succeeded", self, "_on_signup_succeeded")
    Firebase.Auth.login_anonymous()
    
func _exit_tree():
    # Delete the user account on exit
    Firebase.Auth.delete_user_account()
    
func _on_signup_succeeded(auth: Dictionary):
    if auth.has('localid'):
        UUID = auth.localid
        
    # Get Realtime DB reference on successful auth
    db_ref = Firebase.Database.get_database_reference("/", {})
    db_ref.connect("new_data_update", self, "_on_data_update")

func _on_data_update(data):
    print(data)
    
func _on_CreateRoom_pressed():
    if UUID.length() > 1:
        $RoomCode.text = utils.fCRC32(UUID)

func _on_JoinRoom_pressed():
    print('Joining room...')

func _on_LineEdit_text_changed(new_text: String):
    if new_text.length() == 8:
        $JoinRoom.disabled = false
    else:
        $JoinRoom.disabled = true
