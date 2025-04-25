extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var ground_1: TileMap = $"../Ground1"
@onready var ground_2: TileMap = $"../Ground2"
@onready var timer: Timer = $"../Timer"
@onready var scoreText: Label = $"../Score"
@onready var player: Player = $"../Player"
@onready var main_menu: Panel = $"../MainMenu"
@onready var stop_watch: Panel = $"../StopWatch"

var isPlaying: bool

const SPEED_BASE = 100
var SPEED
const DIRECTION = -1
var VELOCITY
var GROUND_WIDTH

const rocket_scene = preload("res://scenes/enemy_rocket.tscn")
const blade_scene = preload("res://scenes/enemy_blade.tscn")
const spike_scene = preload("res://scenes/enemy_spike.tscn")
const enemiesType := [rocket_scene, blade_scene, spike_scene]

var SCORE: int

var lastSpawnTime = 0.0
var spawnInterval = 0.0

const SPAWN_TIME_MIN_CAP = 0.5
const SPAWN_TIME_MIN_BASE = 2.0
var SPAWN_TIME_MIN
const SPAWN_TIME_MAX_CAP = 3.0
const SPAWN_TIME_MAX_BASE = 5.0
var SPAWN_TIME_MAX
const SPAWN_TIME_MODIFIER = -0.1

const SPAWN_X = 100
const SPAWN_Y_MIN = -8
const SPAWN_Y_MAX = -40
const DESPAWN_X = -(SPAWN_X)

var enemies: Array
var lastEnemy: Enemy

const PLAYER_X = -40.0

func reset():
	isPlaying = false
	for enemy in get_children():
		if enemy is Enemy:
			enemy.queue_free()
	ground_1.position.x = 0
	GROUND_WIDTH = ground_1.get_used_rect().size.x * ground_1.tile_set.tile_size.x
	ground_2.position.x = GROUND_WIDTH
	
	SPAWN_TIME_MIN = SPAWN_TIME_MIN_BASE
	SPAWN_TIME_MAX = SPAWN_TIME_MAX_BASE
	lastSpawnTime = Time.get_ticks_msec() / 1000.0
	spawnInterval = randf_range(SPAWN_TIME_MIN, SPAWN_TIME_MAX)
	
	SPEED = SPEED_BASE
	VELOCITY = get_velocity()
	
	player.position.x = PLAYER_X
	player.set_frame(5)
	SCORE = 0
	
	main_menu.get_node("Title").text = "RoboRunner"
	
	stop_watch.reset()

func start():
	isPlaying = true
	main_menu.visible = false
	player.play()

func end():
	isPlaying = false
	main_menu.visible = true
	main_menu.get_node("Title").text = "GAME OVER"
	SPEED = 0
	VELOCITY = get_velocity()
	player.stop()

func _ready() -> void:
	reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isPlaying:
		if Input.is_action_just_pressed("ui_accept"):
			reset()
			start()
		return
	
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
	
func get_velocity():
	VELOCITY = SPEED * DIRECTION
	return VELOCITY
	
func increase_difficulty():
	print("SCORE REACHED "+str(SCORE))
	SPEED += 10
	VELOCITY = get_velocity()
	print("INCREASE DIFFICULTY: "+str(SPEED))
	print("SPEED: "+str(SPEED))
	SPAWN_TIME_MIN += SPAWN_TIME_MODIFIER
	SPAWN_TIME_MIN = max(SPAWN_TIME_MIN_CAP, SPAWN_TIME_MIN)
	print("SPAWN_TIME_MIN: "+str(SPAWN_TIME_MIN))
	SPAWN_TIME_MAX += SPAWN_TIME_MODIFIER
	SPAWN_TIME_MAX = max(SPAWN_TIME_MAX_CAP, SPAWN_TIME_MAX)
	print("SPAWN_TIME_MAX: "+str(SPAWN_TIME_MAX))
	player.increase_frame(5)
