extends Node

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var ground_1: TileMap = $"../Ground1"
@onready var ground_2: TileMap = $"../Ground2"

var SPEED = 1
var DIRECTION = -1
var VELOCITY = -1
var GROUND_WIDTH
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ground_1.position.x = 0
	GROUND_WIDTH = ground_1.get_used_rect().size.x * ground_1.tile_set.tile_size.x
	ground_2.position.x = GROUND_WIDTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ground_1.position.x += VELOCITY
	ground_2.position.x += VELOCITY
	if ground_1.position.x < -GROUND_WIDTH:
		ground_1.position.x = ground_2.position.x + GROUND_WIDTH
	if ground_2.position.x < -GROUND_WIDTH:
		ground_2.position.x = ground_1.position.x + GROUND_WIDTH

func get_speed() -> int:
	return SPEED
	
func get_velocity() -> int:
	return SPEED * DIRECTION
