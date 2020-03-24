extends Node2D

var unit_movable = []
export(int,1,1000) var nb_of_units
var formation = "square"

func _ready():
	for x in $ui/tex/HBoxContainer.get_children():
		x.connect("pressed",self,"ui_formation_button_down",[x.get_name()])
	ui_formation_button_down("square")
	while nb_of_units > 0:
		nb_of_units -=1
		var unit = load("res://scenes/unit/unit.tscn").instance()
		$nav/units.add_child(unit)
		unit.position = $nav/units/unit_spawn_pos.position

func ui_formation_button_down(formation_name):
	for x in $ui/tex/HBoxContainer.get_children():
		x.disabled = false
	get_node("ui/tex/HBoxContainer/"+str(formation_name)).disabled = true
	formation = formation_name
	

func select_unit(unit,is_selected):
	if !unit in unit_movable:
		unit.get_node("sprite").material.set_shader_param("visible",is_selected)
		unit.get_node("sprite").material.set_shader_param("outline_color",Color("1fa0ff"))

func selection_ended(units_selected):
	reset_selection()
	unit_movable = units_selected
	for x in units_selected:
		x.get_node("sprite").material.set_shader_param("visible",true)
		x.get_node("sprite").material.set_shader_param("outline_color",Color("70cb71"))
	$ui/tex/unit_selected/nb_of_unit.text = str(unit_movable.size())

func reset_selection():
	for x in unit_movable:
		x.get_node("sprite").material.set_shader_param("visible",false)
	unit_movable = []

func _input(event):
	if event.is_action_pressed("right_click"):
		if unit_movable:
			if $ui/tex/random/unit_position_random.pressed:
				unit_movable.shuffle()
			print(str(formation)+"Formation")
			funcref(self,str(formation)+"Formation").call_func(unit_movable, get_global_mouse_position())
#			circleFormation(unit_movable, get_global_mouse_position())

func randomFormation(unit_array, mousepos):
	var formation_array = ["square","circle","triangle"]
	print(formation_array[randi() % formation_array.size()])
	funcref(self,str(formation_array[randi() % formation_array.size()])+"Formation").call_func(unit_movable, get_global_mouse_position())

func squareFormation(unit_array, mousepos):
	var number_of_unit = unit_array.size()
	var square_side_size = round(sqrt(number_of_unit))
	var space_between_units = 20
	var unit_pos = mousepos - space_between_units * Vector2(square_side_size/2,square_side_size/2)
	for x in unit_array:
		x.move_setting(unit_pos)
		unit_pos.x += space_between_units
		if unit_pos.x > (mousepos.x + square_side_size * space_between_units / 2):
			unit_pos.y += space_between_units
			unit_pos.x = mousepos.x - space_between_units * square_side_size/2

func triangleFormation(unit_array, mousepos):
	var number_of_unit = unit_array.size()
	var triangle_base_size = round(sqrt(2*number_of_unit))
	var space_between_units = 20
	var unit_pos = mousepos - space_between_units * Vector2(0,triangle_base_size/2)
	var unit_count_in_line = 0
	var unit_total_in_line = 1
	for x in unit_array:
		x.move_setting(unit_pos)
		unit_pos.x += space_between_units
		unit_count_in_line += 1
		if unit_count_in_line >= unit_total_in_line:
			unit_count_in_line = 0
			unit_total_in_line += 1
			unit_pos.y += space_between_units
			unit_pos.x = mousepos.x - space_between_units * (unit_total_in_line-1)/2

func circleFormation(unit_array, mousepos):
	var unit_pos = mousepos
	var space_between_units = 20
	var circle_size = 0
	var unit_total_count_in_circle = 6 * circle_size
	var unit_count_in_circle = 0
	var current_angle = 0
	for x in unit_array:
		x.move_setting(unit_pos)
		unit_count_in_circle += 1
		if unit_count_in_circle >= unit_total_count_in_circle:
			unit_count_in_circle = 0
			current_angle = 0
			circle_size += 1
			unit_total_count_in_circle = 6 * circle_size
			unit_pos.x = mousepos.x + space_between_units * circle_size
			unit_pos.y = mousepos.y
		else:
			current_angle += (PI/3) / circle_size
			unit_pos.x = mousepos.x + (space_between_units * circle_size) * cos(current_angle)
			unit_pos.y = mousepos.y + (space_between_units * circle_size) * sin(current_angle)
