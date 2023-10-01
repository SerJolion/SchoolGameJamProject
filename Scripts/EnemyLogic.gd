extends Node2D

@export var Speed:float = 200

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position.y += Speed * delta
	if position.y >= 1000:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("Die"):
		body.Die()
