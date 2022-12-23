extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Main/Game").visible = false
	#get_node("/root/Node2D/Button").set_deferred("disabled", true)
	#get_node("/root/Node2D/Button").text += " (Work in progress)"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_node("/root/Main/MainMenu").visible = false
	get_node("/root/Main/Game").visible = true
	pass # Replace with function body.


func _on_Button2_pressed():
	get_tree().quit()
	pass # Replace with function body.
