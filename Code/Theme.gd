class_name MineTheme extends Object

export(Texture) var plate
export(Texture) var plateFlag
export(Texture) var plateBomb
export(Texture) var pressedPlate
export(Texture) var plateNumbers

#название папки в Textures/theme
func load_theme(theme_name):
	plate = load("res://Textures/themes/" + theme_name + "/plate.png")

	if plate == null:
		print("ERROR!!! не хватает текстуры plate.png в указанной теме")
		
	plateFlag = load("res://Textures/themes/" + theme_name + "/plateFlag.png")
	
	if plateFlag == null:
		print("ERROR!!! не хватает текстуры platebomb.png в указанной теме")
		
	plateBomb = load("res://Textures/themes/" + theme_name + "/plateBomb.png")
	
	if plateBomb == null:
		print("ERROR!!! не хватает текстуры plateBomb.png в указанной теме")
		
	pressedPlate = load("res://Textures/themes/" + theme_name + "/pressedPlate.png")
	
	if pressedPlate == null:
		print("ERROR!!! не хватает текстуры pressedPlate.png в указанной теме")
		
	plateNumbers = []

	for i in range(1, 4):
		plateNumbers.append(load("res://Textures/themes/" + theme_name + "/plateNumber_" + String(i) + ".png"))
		
		if plateNumbers[i-1] == null:
			var str1 = "ERROR!!! не хватает текстуры plateNumber_" + String(i) + ".png в указанной теме"
			print(str1)
		
	
