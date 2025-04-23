extends Area2D
class_name Enemy
#right click on enemy.tscn then New Inherited Scene
@onready var game_manager: Node = get_tree().root.get_node("Game/GameManager")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var enemy_name: String
@onready var score: Label = $"../Score"

var VELOCITY
var DESPAWN_X
var PLAYER_X: float
#var ADD_SCORE: bool

func _ready() -> void:
	VELOCITY = game_manager.VELOCITY
	DESPAWN_X = game_manager.DESPAWN_X
	PLAYER_X = game_manager.PLAYER_X
	#ADD_SCORE = true
	
func _process(delta: float) -> void:
	position.x += VELOCITY * delta
	if position.x < DESPAWN_X:
		queue_free()
	#if position.x < PLAYER_X && ADD_SCORE:
		#ADD_SCORE = false
		#game_manager.add_score(1)

func _on_body_entered(body: Node2D) -> void:
	print("DEATH CAUSE: collide with "+name)
	get_tree().paused = true
