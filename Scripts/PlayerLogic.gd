extends CharacterBody2D


@export var Speed:float = 300
@export var JumpSpeed:float = -500
@export var Gravity:float = 980

var Visual:AnimatedSprite2D
var dead:bool = false

func _ready():
	Visual = $AnimatedSprite2D

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += Gravity * delta
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JumpSpeed
	var Dir = Input.get_axis("ui_left","ui_right")
	if Dir > 0:
		Visual.flip_h = false
		Visual.play("Run")
	elif Dir == 0:
		Visual.play("Idle")
	else:
		Visual.flip_h = true
		Visual.play("Run")

	velocity.x = Dir * Speed
	move_and_slide()

func Die():
	get_tree().quit()
