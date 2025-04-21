extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var ground_1: TileMap = $"../Ground1"
@onready var ground_2: TileMap = $"../Ground2"
@onready var timer: Timer = $"../Timer"

var SPEED = 100
var DIRECTION = -1
var VELOCITY = SPEED * DIRECTION
var GROUND_WIDTH

const rocket_scene = preload("res://scenes/enemy_rocket.tscn")
const blade_scene = preload("res://scenes/enemy_blade.tscn")
const spike_scene = preload("res://scenes/enemy_spike.tscn")
const enemiesType := [rocket_scene, blade_scene, spike_scene]

var lastSpawnTime = 0.0
var spawnInterval = 0.0

const SPAWN_TIME_MIN = 2.0
const SPAWN_TIME_MAX = 5.0

const SPAWN_X = 100
const SPAWN_Y_MIN = -8
const SPAWN_Y_MAX = -40
const DESPAWN_X = -(SPAWN_X)

var enemies: Array
var lastEnemy: Enemy

func _ready() -> void:
	ground_1.position.x = 0
	GROUND_WIDTH = ground_1.get_used_rect().size.x * ground_1.tile_set.tile_size.x
	ground_2.position.x = GROUND_WIDTH
	VELOCITY = SPEED * DIRECTION
	
	lastSpawnTime = Time.get_ticks_msec() / 1000.0
	spawnInterval = randf_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var res = VELOCITY * delta
	ground_1.position.x += res
	ground_2.position.x += res
	if ground_1.position.x < -GROUND_WIDTH:
		ground_1.position.x = ground_2.position.x + GROUND_WIDTH
	if ground_2.position.x < -GROUND_WIDTH:
		ground_2.position.x = ground_1.position.x + GROUND_WIDTH
		
	var currentTime = Time.get_ticks_msec()/1000.0
	if currentTime - lastSpawnTime >= spawnInterval:
		lastSpawnTime = currentTime
		spawnInterval = randf_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX)
		spawn_enemy()
	
func spawn_enemy():
	var enemyType = enemiesType[randi() % enemiesType.size()]
	var enemy = enemyType.instantiate()
	enemy.position = Vector2i(SPAWN_X, SPAWN_Y_MIN)
	add_child(enemy)
	print("SPAWNED: "+enemy.enemy_name)
