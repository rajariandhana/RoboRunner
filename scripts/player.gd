extends CharacterBody2D
class_name Player

const JUMP_VELOCITY = -250

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var animated_sprite_2d:AnimatedSprite2D
@onready var collision_run: CollisionShape2D = $CollisionRun
@onready var collision_jump: CollisionShape2D = $CollisionJump

var isRunning:bool

func _ready() -> void:
	#await get_tree().create_timer(1).timeout
	collision_run.disabled = true
	collision_jump.disabled = true
	print("Hello woarld")
	animated_sprite_2d = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	if !isRunning:
		return
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

func set_frame(frame: int):
	#animated_sprite_2d.sprite_frames.set_animation_speed("run",frame)
	pass

func increase_frame(frame: int):
	#var oldFrame = animated_sprite_2d.sprite_frames.get_animation_speed("run")
	#animated_sprite_2d.sprite_frames.set_animation_speed("run", oldFrame+5)
	pass
	
func play():
	isRunning = true
	collision_run.disabled = false
	collision_jump.disabled = true

func stop():
	isRunning = false
	animated_sprite_2d.stop()
