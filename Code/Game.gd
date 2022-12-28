extends Node2D

const MINE = 0
const FLAG = 1
const EMPTY = 2
const EMPTY_HIT = 3
var board = {}
var mines = []
var died = false
var columns = 8
var rows = 8
var mines_count = 10
var theme = MineTheme.new()
var buttons = [[]]

func create_field():
	for i in int(columns):
		for j in int(rows):
			var butt = TextureButton.new()
			$Buttons.add_child(butt)
			board[Vector2(i,j)] = EMPTY
			butt.set_position(Vector2(350+(j*32), 100+(i*32)))
			butt.set_size(Vector2(32,32))
			butt.set_normal_texture(theme.plate)
			butt.set_pressed_texture(theme.pressedPlate)
			butt.connect("gui_input", self, "sweep", [butt, j, i])
					
func create_mines():
	var random = RandomNumberGenerator.new()
	
	for i in int(mines_count):
		random.randomize()
		
		var MineX = random.randi_range(0,int(columns)-1)
		var MineY = random.randi_range(0,int(rows)-1)
		
		if Vector2(MineX, MineY) in board and board[Vector2(MineX, MineY)] != MINE:	
			board[Vector2(MineX, MineY)] = MINE

			print("Мина расположена на: ", MineX, " ", MineY)
			
			$Buttons.get_child((columns*MineY)+MineX+1).connect("gui_input", self, "mine",[$Buttons.get_child((columns*MineY)+MineX+1)])
			mines.append($Buttons.get_child((columns*MineY)+MineX+1))	

func process_cmd():
	print(OS.get_cmdline_args())
	get_node("/root/Main/MainMenu").visible = false
	
	if OS.get_cmdline_args().size() == 3:
		columns = OS.get_cmdline_args()[0]
		rows = OS.get_cmdline_args()[1]
		mines_count = OS.get_cmdline_args()[2]
		
func _ready():
	
	theme.load_theme("default")
	
	process_cmd()
	
	create_field()

	create_mines()
	
func mine(event, x):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				for mine in mines:
					mine.set_normal_texture(theme.plateBomb)
				print("Game Over!")
				died = true
			BUTTON_RIGHT:
				if !died:
					x.set_normal_texture(theme.plateFlag)
					
func sweep(event, btn, x, y):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			BUTTON_LEFT:
				if !died and board[Vector2(x,y)] != FLAG:
					var local_mines = 0
					for i in 3:
						for j in 3:
							if Vector2(x-1+i,y-1+j) in board:
								if board[Vector2(x-1+i, y-1+j)] == MINE:
									local_mines += 1
									print("Мина найдена на:", x-1+i, " ", y-1+j)
									print("Нажатие было на:", x, " ", y)
					print(local_mines)
					if local_mines > 0 || local_mines <= 4:
						btn.set_normal_texture(theme.plateNumbers[local_mines-1])
					else:
						btn.set_normal_texture(theme.pressedPlate)
						board[Vector2(x,y)] = EMPTY_HIT
			BUTTON_RIGHT:
				if !died:
					if Vector2(x,y) in board:
						if board[Vector2(x,y)] != EMPTY and board[Vector2(x,y)] != EMPTY_HIT:
							board[Vector2(x,y)] = EMPTY
							btn.set_normal_texture(theme.plate)
						elif board[Vector2(x,y)] != EMPTY_HIT:
							board[Vector2(x,y)] = FLAG
							
							btn.set_normal_texture(theme.plateFlag)
							
