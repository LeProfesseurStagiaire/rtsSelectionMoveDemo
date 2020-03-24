extends Node2D

onready var nav = get_tree().get_current_scene().get_node("nav")
onready var line = load("res://scenes/unit/line.tscn").instance()

var _path: PoolVector2Array

func _ready():
	get_parent().call_deferred("add_child",line)
	$sprite.set_material($sprite.get_material().duplicate())
	set_process(false)

func move_setting(pos):
	set_process(true)
	_path = nav.get_simple_path(position, pos)
	_path.insert(0,position)
	line.points = _path

func _process(delta: float):
	if _path.size() > 1:
		var d: float = position.distance_to(_path[1])
		if d > 5:
			position = position.linear_interpolate(_path[1], (200 * delta)/d)
			look_at(_path[1])
		else:
			_path.remove(1)
		_path[0] = position
		line.points = _path
	else:
		set_process(false)
