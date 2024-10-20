extends StaticBody2D

var ball_pos : Vector2
var dist : int
var move_by : int
var win_height : int
var p_height : int
var reaction_time : float = 0.0165  # Shorter delay, quicker reactions
var reaction_timer : float = 0.0
var slight_error_margin : float = 5.0  # Simulates small human error

func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.size.y

func _process(delta):
	reaction_timer += delta
	if reaction_timer >= reaction_time:
		ball_pos = $"../Ball".position
		dist = position.y - ball_pos.y
		
		# Introduce a slight error margin to make it less perfect
		dist += randf_range(-slight_error_margin, slight_error_margin)
		
		if abs(dist) > get_parent().PADDLE_SPEED * delta:
			move_by = get_parent().PADDLE_SPEED * delta * (dist / abs(dist))
		else:
			move_by = dist
		
		position.y -= move_by
		position.y = clamp(position.y, p_height/2 - 50, win_height-p_height/2 - 40)
		
		reaction_timer = 0.0  # Reset the reaction timer
