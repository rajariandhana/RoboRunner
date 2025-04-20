extends CharacterBody2D
class_name Player

const JUMP_VELOCITY = -250

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_run: CollisionShape2D = $CollisionRun
@onready var collision_jump: CollisionShape2D = $CollisionJump

func _ready() -> void:
	print("Hello woarld")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		animated_sprite_2d.play("run")
		collision_run.disabled = false;
		collision_jump.disabled = true;
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
			animated_sprite_2d.play("jump")
			collision_run.disabled = true;
			collision_jump.disabled = false;
	
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		velocity.x = direction * 100
	else:
		velocity.x = move_toward(velocity.x,0,100)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("DEATH FOR YOU!")


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("DEATH FOR YOsdsdU!")
