extends Node2D
#signal pressed(x)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mines = []
var died = false
# Called when the node enters the scene tree for the first time.

func _ready():
	
	get_node("/root/Main/MainMenu").visible = false
	
	
	for i in 9:
		for j in 9:
			#print(i,j)
			var butt = TextureButton.new()
			$chd.add_child(butt)
			
			butt.set_position(Vector2(350+(j*32),100+(i*32)))
			butt.set_size(Vector2(32,32))
			butt.set_normal_texture(load("res://plate.png"))
			butt.set_pressed_texture(load("res://pressedplate.png"))
			#butt.set_focused_texture(load("res://pressedplate.png"))
			#if MineX == i and MineY == j:
			butt.connect("gui_input", self, "sweep", [butt])
				
	#$chd.get_child(1).connect("pressed", self, "sweep")
	var rng = RandomNumberGenerator.new()
	for i in 10:
		rng.randomize()
		var MineX = rng.randi_range(0,8)
		var MineY = rng.randi_range(0,8)
		#print(MineX, MineY)
		print((MineX+1)*(MineY+1))
		#emit_signal("pressed", $chd.get_child((MineX+1)*(MineY+1)))
		if $chd.get_child((MineX+1)*(MineY+1)).is_connected("gui_input", self, "mine") == false:
			$chd.get_child((MineX+1)*(MineY+1)).connect("gui_input", self, "mine",[$chd.get_child((MineX+1)*(MineY+1))])
		mines.append($chd.get_child((MineX+1)*(MineY+1)))
	pass # Replace with function body.
	
func mine(event, x):
	#x.set_normal_texture(load("res://pplatebomb.png"))
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				for mine in mines:
					mine.set_normal_texture(load("res://pplatebomb.png"))
				print("Game Over!")
				died = true
			BUTTON_RIGHT:
				x.set_normal_texture(load("res://plateflag.png"))
func sweep(event, x):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				if !died:
					x.set_normal_texture(load("res://pressedplate.png"))
			BUTTON_RIGHT:
				if !died:
					x.set_normal_texture(load("res://plateflag.png"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
