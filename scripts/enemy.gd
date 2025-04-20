extends Area2D
class_name Enemy

@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	position.x += game_manager.get_velocity() * delta
