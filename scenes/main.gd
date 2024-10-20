extends Sprite2D

var score := [0,0] #0:Player, 1:CPU
const PADDLE_SPEED : int = 500

func _ready():
	#var bgm = preload("res://assets/bgm.mp3")
	#$"../AudioStreamPlayer".stream = bgm;
	
	$"BGM".play()

func _on_ball_timer_timeout():
	$Ball.new_ball()


func _on_scrore_left_body_entered(body):
	score[1] += 1
	$Hud/CpuScore.text = str(score[1])
	$Score.play()
	$BallTimer.start()
	
func _on_score_right_body_entered(body):
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	$Score.play()
	$BallTimer.start()
