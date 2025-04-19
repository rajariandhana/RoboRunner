extends CharacterBody2D

const JUMP_VELOCITY = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		animated_sprite_2d.play("run")
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.play("jump")

	move_and_slide()
