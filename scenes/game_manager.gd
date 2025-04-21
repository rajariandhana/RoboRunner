extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var ground_1: TileMap = $"../Ground1"
@onready var ground_2: TileMap = $"../Ground2"

var SPEED = 60
var DIRECTION = -1
var VELOCITY = -60
var GROUND_WIDTH

#var rocket_scene = preload("res://scenes/enemy.tscn")
#var enemies_type := [rocket_scene, ...]

func _ready() -> void:
	ground_1.position.x = 0
	GROUND_WIDTH = ground_1.get_used_rect().size.x * ground_1.tile_set.tile_size.x
	ground_2.position.x = GROUND_WIDTH
	VELOCITY = SPEED * DIRECTION

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var res = VELOCITY * delta
	ground_1.position.x += res
	ground_2.position.x += res
	if ground_1.position.x < -GROUND_WIDTH:
		ground_1.position.x = ground_2.position.x + GROUND_WIDTH
	if ground_2.position.x < -GROUND_WIDTH:
		ground_2.position.x = ground_1.position.x + GROUND_WIDTH

func get_speed() -> int:
	return SPEED
	
func get_velocity() -> int:
	return VELOCITY

func spawn_enemy() -> void:
	pass
	#var enemy_type = enemies_type[randi() % enemies_type.size()]
	#var newEnemy
	#newEnemy = enemy_type.instantiate()
	#append some shit

func despawn_enemy(enemy: Enemy) -> void:
	pass
	enemy.queue_free()
	#remove from array shit
	
