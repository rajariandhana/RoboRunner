extends Area2D
class_name Enemy
#right click on enemy.tscn then New Inherited Scene
@onready var game_manager: Node = get_tree().root.get_node("Game/GameManager")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var enemy_name: String

var VELOCITY
var DESPAWN_X

func _ready() -> void:
	VELOCITY = game_manager.VELOCITY
	DESPAWN_X = game_manager.DESPAWN_X
	
func _process(delta: float) -> void:
	position.x += VELOCITY * delta
	if position.x < DESPAWN_X:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("DEATH CAUSE: collide with "+name)
	get_tree().paused = true
