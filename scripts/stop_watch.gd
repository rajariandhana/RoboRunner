extends Panel

@onready var game_manager: Node = %GameManager

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var miliseconds: int = 0

@onready var minutesLabel: Label = $Minutes
@onready var secondsLabel: Label = $Seconds
@onready var milisecondsLabel: Label = $Miliseconds

var last_difficulty_increase_time: int = -10

func reset():
	time = 0.0
	minutes = 0
	seconds = 0
	miliseconds = 0

func _ready() -> void:
	reset()
	print("TIME SET")

func _process(delta: float) -> void:
	if !game_manager.isPlaying:
		return
		
	time += delta
	miliseconds = fmod(time, 1) * 100
	seconds = fmod(time, 60)

	minutes = fmod(time, 3600) / 60
	minutesLabel.text = str("%02d:" % minutes)
	secondsLabel.text = str("%02d:" % seconds)
	milisecondsLabel.text = str("%02d" % miliseconds)
	
	if int(time) % 5 == 0 and int(time) != last_difficulty_increase_time:
		game_manager.increase_difficulty()
		last_difficulty_increase_time = int(time)
