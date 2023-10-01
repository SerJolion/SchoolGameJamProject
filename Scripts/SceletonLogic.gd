extends CharacterBody2D

enum States{IDLE, FALL, RUN, DEAD}

@export var Speed:float = 300.0
@export var Gravity:float = 980
@export var LifeTime:float = 5

var CurrentState:States


var Visual:AnimatedSprite2D

func _ready():
	Visual = $Visual
	SetState(States.FALL)

func _physics_process(delta):
	
	match CurrentState:
		States.IDLE:
			Visual.play("Idle")
			if position.x >= 550:
				velocity.x = -Speed
			else:
				velocity.x = Speed
			SetState(States.RUN)
		States.FALL:
			Visual.play("Idle")
			velocity.y += Gravity*delta
			if is_on_floor():
				SetState(States.IDLE)
		States.RUN:
			if velocity.x > 0:
				Visual.flip_h = false
			else:
				Visual.flip_h = true
			Visual.play("Run")
			if !is_on_floor():
				velocity.x = 0
				SetState(States.FALL)
			if is_on_wall():
				velocity.x = -velocity.x
		States.DEAD:
			velocity.x = 0
			if LifeTime <= -2:
				queue_free()

	LifeTime -= delta
	if LifeTime <= 0 and CurrentState != States.DEAD:
		SetState(States.DEAD)
	move_and_slide()


func SetState(NewState:States):
	match NewState:
		States.DEAD:
			$HitBox.monitoring = false
			Visual.play("Death")
	CurrentState = NewState

func _on_hit_box_body_entered(body):
	if body.has_method("Die"):
		body.Die()
