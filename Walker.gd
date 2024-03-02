extends TileMap
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position)) #Checkea que la starting_position esté dentro de los borders
	position = starting_position
	step_history.append(position)
	borders = new_borders
	
func walk(steps):
	for step in steps:
		if randf() <= 0.25 or steps_since_turn >= 4:
			change_direction()
		
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history
	
func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false #Porque no podemos ir por fuera de los borders

func change_direction():
	steps_since_turn = 0
	var directions = DIRECTIONS
	directions.erase(direction)
	direction.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction): 
		direction = directions.pop_front()             #Va a ir tomando direcciones hasta que alguna le permita no salirse de los borders
