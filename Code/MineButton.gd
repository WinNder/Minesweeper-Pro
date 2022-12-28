class_name MineButton extends TextureButton

enum ButtonType {
	EMPTY,
	MINE,
	NUMBER
}

export(int) var type
	
func set_type(p_type, number, p_theme):
	
	self.texture_normal = p_theme.plate
	match p_type:
		ButtonType.MINE:
			self.texture_pressed = p_theme.plateBomb
		ButtonType.NUMBER:
			self.texture_pressed = p_theme.plateNumber[number]
		ButtonType.EMPTY:
			self.texture_pressed = p_theme.platePressed

func make_is_flag(p_theme):
	self.texture_normal = p_theme.plateFlag
