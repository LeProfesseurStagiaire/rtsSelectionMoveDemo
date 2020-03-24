extends Control

var unit_selected = []
var is_selecting = false
onready var main = get_tree().get_current_scene()

func _ready():
	draw_selection(PoolVector2Array([Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]))
	$aera.connect("area_entered",self,"selection",[true])
	$aera.connect("area_exited",self,"selection",[false])
	is_selecting = false

func _input(event):
	if event is InputEventMouseMotion && is_selecting:
		var mouse = get_global_mouse_position()
		var pos = $aera/col.shape.get_points()[0]
		draw_selection(PoolVector2Array([Vector2(pos.x,pos.y),Vector2(mouse.x,pos.y),mouse,Vector2(pos.x,mouse.y)]))
	if event.is_action_released("mouse_click") && is_selecting:
		main.selection_ended(unit_selected)
		end_selection()
	if event.is_action_pressed("mouse_click"):
		if not is_selecting && get_global_mouse_position().y <= main.get_node("ui/tex").get_global_rect().position.y:
			is_selecting = true
			main.reset_selection()
		else:
			end_selection()
		if is_selecting:
			draw_selection(PoolVector2Array([get_global_mouse_position(),get_global_mouse_position(),get_global_mouse_position(),get_global_mouse_position()]))

func end_selection():
	is_selecting = false
	draw_selection(PoolVector2Array([Vector2(0,0),Vector2(0,0),Vector2(0,0),Vector2(0,0)]))
	unit_selected = []

func selection(area,selected):
	if area.is_in_group("unit"):
		var unit = area.get_parent()
		main.select_unit(unit,selected)
		if selected:
			unit_selected.append(unit)
		else:
			unit_selected.erase(unit)

func draw_selection(pos):
	$aera/col.shape.set_points(pos)
	$select_shape.set_begin(Vector2(min(pos[0].x,pos[2].x),min(pos[0].y,pos[2].y)))
	$select_shape.set_end(Vector2(max(pos[0].x,pos[2].x),max(pos[0].y,pos[2].y)))
