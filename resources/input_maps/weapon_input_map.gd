extends GameObjectInputMap

func _ready():
	input_map = {"shoot": shoot(), "aim": aim()}

func shoot():
	print(name + " custom shoot function")

func aim():
	print(name + " shoot")
