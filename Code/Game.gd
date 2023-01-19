extends Node2D
#signal pressed(x)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MINE = 0
const FLAG = 1
const EMPTY = 2
const EMPTY_HIT = 3
const NUMBER = 4
var board = {}
var mines = []
var died = false
var columns = 9
var rows = 9
var mines_count = 2
# Called when the node enters the scene tree for the first time.

func _ready():
	
	print(OS.get_cmdline_args())
	get_node("/root/Main/MainMenu").visible = false
	if OS.get_cmdline_args().size() == 3:
		columns = OS.get_cmdline_args()[0]
		rows = OS.get_cmdline_args()[1]
		mines_count = OS.get_cmdline_args()[2]
		
		
	for i in int(columns):
		for j in int(rows):
			#print(i,j)
			var butt = TextureButton.new()
			$chd.add_child(butt)
			board[Vector2(i,j)] = EMPTY
			butt.set_position(Vector2((j*32),82+(i*32)))
			butt.set_size(Vector2(32,32))
			butt.set_normal_texture(load("res://plate.png"))
			butt.set_pressed_texture(load("res://pressedplate.png"))
			#butt.set_focused_texture(load("res://pressedplate.png"))
			#if MineX == i and MineY == j:
			butt.connect("gui_input", self, "click", [butt, j, i])
				
	#$chd.get_child(1).connect("pressed", self, "sweep")
	var rng = RandomNumberGenerator.new()
	for n in int(mines_count):
		rng.randomize()
		var MineX = rng.randi_range(0,int(columns)-1)
		var MineY = rng.randi_range(0,int(rows)-1)
		if board[Vector2(MineX, MineY)] != MINE:	
			board[Vector2(MineX, MineY)] = MINE
		#print(MineX, MineY)
			print("Мина расположена на: ", MineX, " ", MineY)
			#for b in (columns):
				#for d in (rows):
					#print("x: ", b, " y: ", d, " Ее значение: ", board[Vector2(b, d)])
				#print(" ")
		#emit_signal("pressed", $chd.get_child((MineX+1)*(MineY+1)))
		
			
		#if $chd.get_child((MineX+1)*(MineY+1)).is_connected("gui_input", self, "mine") == false:
			$chd.get_child((columns*MineY)+MineX+1).connect("gui_input", self, "mine",[$chd.get_child((columns*MineY)+MineX+1)])
			mines.append($chd.get_child((columns*MineY)+MineX+1))
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
				if !died:
					x.set_normal_texture(load("res://plateflag.png"))
func click(event, btn, x, y):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				var local_mines = 0
				for i in 3:
					for j in 3:
						if Vector2(x-1+i,y-1+j) in board:
							if board[Vector2(x-1+i, y-1+j)] == MINE:
								local_mines += 1
				if board[Vector2(x, y)] != EMPTY_HIT:
					if local_mines > 0:
						sweep($chd.get_child(columns*y+x+1), x, y)
					elif local_mines == 0:
						for a in 3:
							for b in 3:
								sweep($chd.get_child((columns*(y-1+b))+(x-1+a)+1), x+a-1, y+b-1);
								print("Открываю x: ", x+a-1, " и y: ", y+b-1)
									#else:
										#btn.set_normal_texture(load("res://pressedplate.png"))
										#board[Vector2(i,j)] = EMPTY_HIT
					
#					if Vector2(x+1,y+1) in board:
#						if board[Vector2(x+1, y+1)] == MINE:
#							local_mines += 1
#					if Vector2(x-1,y-1) in board: 
#						if board[Vector2(x-1, y-1)] == MINE:
#							local_mines += 1
#					if Vector2(x-1,y+1) in board: 
#						if board[Vector2(x-1, y+1)] == MINE:
#							local_mines += 1
#					if Vector2(x+1,y-1) in board:
#						if board[Vector2(x+1, y-1)] == MINE: 
#							local_mines += 1
#					if Vector2(x,y+1) in board:
#						if board[Vector2(x, y+1)] == MINE: 
#							local_mines += 1
#					if  Vector2(x,y-1) in board:
#						if board[Vector2(x, y-1)] == MINE: 
#							local_mines += 1
#					if Vector2(x+1,y) in board:  
#						if board[Vector2(x+1, y)] == MINE:  
#							local_mines += 1
#					if Vector2(x-1,y) in board:
#						if board[Vector2(x-1, y)] == MINE:
#							local_mines += 1
					
					
					
			BUTTON_RIGHT:
				if !died: #and x.get_normal_texture() != load("res://pressedplate.png")
					#print(board[Vector2(x,y)])
					if Vector2(x,y) in board:
						if board[Vector2(x,y)] != EMPTY and board[Vector2(x,y)] != EMPTY_HIT:
							board[Vector2(x,y)] = EMPTY
							btn.set_normal_texture(load("res://plate.png"))
						elif board[Vector2(x,y)] != EMPTY_HIT:
							board[Vector2(x,y)] = FLAG
							
							btn.set_normal_texture(load("res://plateflag.png"))
						
					#else:
						#board[Vector2(x, y)] = EMPTY
						
					#if x.get_normal_texture() == load("res://plateflag.png"):
						#x.set_normal_texture(load("res://plate.png"))
					#else:
						
						
						
	
func sweep(btn, x, y):
	if !died and board[Vector2(x,y)] != FLAG:
					var local_mines = 0
					for i in 3:
						for j in 3:
							if Vector2(x-1+i,y-1+j) in board:
								if board[Vector2(x-1+i, y-1+j)] == MINE: #or board[Vector2(x-1+i, y-1+j)] == FLAG:
									local_mines += 1
					if local_mines > 0:
						btn.set_normal_texture(load("res://pplate_"+str(local_mines)+".png"))
						#board[Vector2(x,y)] = NUMBER
					else:
						btn.set_normal_texture(load("res://pressedplate.png"))
						board[Vector2(x,y)] = EMPTY_HIT
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
