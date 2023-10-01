extends Node

@export_file("*.tscn") var EnemyScenePath:String

var EnemyScene:PackedScene
var EnemySpawnPoint:PathFollow2D
var World:Node2D

func _ready():
	World = $World
	EnemySpawnPoint = $World/Path2D/EnemySpawnPoint
	EnemyScene = load(EnemyScenePath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_spawn_timer_timeout():
	if EnemyScene != null:
		var NewEnemy:Node2D = EnemyScene.instantiate()
		EnemySpawnPoint.progress_ratio = randf()
		World.add_child(NewEnemy)
		NewEnemy.position = EnemySpawnPoint.position
		NewEnemy.Speed = randf_range(100, 300)
