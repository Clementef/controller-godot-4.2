extends Button

func _ready():
	button_down.connect(owner._button_pressed.bind(get_index()))
