extends Node
class_name GameObjectInputMap

var input_map:Dictionary = \
{
	"shoot": Callable(self, "shoot"),
	"shoot_release": Callable(self, "shoot_release"),
	"aim": Callable(self, "aim"),
	"aim_release": Callable(self, "aim_release"),
}

func shoot():
	print(name + " default input function for: shoot")
func shoot_release():
	print(name + " default input function for: shoot_release")

func aim():
	print(name + " default input function for: aim")
func aim_release():
	print(name + " default input function for: aim_release")
