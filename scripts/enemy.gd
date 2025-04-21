extends Area2D
class_name Enemy
#right click on enemy.tscn then New Inherited Scene
@onready var game_manager: Node = get_tree().root.get_node("Game/GameManager")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var VELOCITY

func _ready() -> void:
	VELOCITY = game_manager.get_velocity()
	
func _process(delta: float) -> void:
	position.x += VELOCITY * delta

func _on_body_entered(body: Node2D) -> void:
	print("DEATHSDSDMSDJNSDJ")
	queue_free
