extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500
const ACCEL : int = 50
var speed : int
const MAX_Y_VECTOR : float = 0.6

var dir : Vector2

func _ready():
	win_size = get_viewport_rect().size
	
	
func new_ball():
	position.x = win_size.x/2
	position.y = randf_range(200,win_size.y-200)
	speed = START_SPEED
	dir = random_direction()
	
	
func _physics_process(delta):
	var collison = move_and_collide(dir*speed*delta)
	var collider
	if collison:
		collider = collison.get_collider()
		if collider == $"../Player" || collider == $"../CPU":
			$AudioStreamPlayer.play()
			speed += ACCEL
			dir = new_direction(collider)
		elif collider == $"../Borders":
			speed -= ACCEL*0.70
			dir = dir.bounce(collison.get_normal())

	
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1,-1].pick_random()
	new_dir.y = randf_range(1,-1)
	return new_dir.normalized()
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
		
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
