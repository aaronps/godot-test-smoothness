extends Node

const WANTED_FRAMES = 60

const PROCESS_SPEED_PER_SECOND = 60
const PROCESS_SPEED_PER_FRAME = PROCESS_SPEED_PER_SECOND / WANTED_FRAMES
const FIXED_RATE = 60
const FIXED_PROCESS_SPEED_PER_SECOND = 60
const FIXED_PROCESS_SPEED_PER_FRAME = FIXED_PROCESS_SPEED_PER_SECOND / FIXED_RATE


var smoothedDeltaRealTime_ms = 0.0160 #0.0085 #0.0175
var movAverageDeltaTime_ms = smoothedDeltaRealTime_ms
const movAveragePeriod = 60.0
const smoothFactor = 0.2

onready var process_1 = get_node('process_1')
onready var process_2 = get_node('process_2')
onready var process_3 = get_node('process_3')
onready var byengine_1 = get_node('byengine_1')
onready var fixed_1 = get_node('fixed_1')
onready var fixed_2 = get_node('fixed_2')

var WIN_WIDTH = 1024

func _ready():
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	var p = process_1.get_pos()
	p.x += delta * PROCESS_SPEED_PER_SECOND
	if p.x >= WIN_WIDTH:
		p.x = -64
	process_1.set_pos(p)
	
	p = process_2.get_pos()
	p.x += PROCESS_SPEED_PER_FRAME
	if p.x >= WIN_WIDTH:
		p.x = -64
	process_2.set_pos(p)
	
	p = process_3.get_pos()
	p.x += PROCESS_SPEED_PER_SECOND * smoothedDeltaRealTime_ms
	movAverageDeltaTime_ms=(delta + movAverageDeltaTime_ms*(movAveragePeriod-1))/movAveragePeriod
	smoothedDeltaRealTime_ms=smoothedDeltaRealTime_ms +(movAverageDeltaTime_ms - smoothedDeltaRealTime_ms)* smoothFactor
	if p.x >= WIN_WIDTH:
		p.x = -64
	process_3.set_pos(p)
	

func _fixed_process(delta):
	var p = fixed_1.get_pos()
	p.x += delta * FIXED_PROCESS_SPEED_PER_SECOND
	if p.x >= WIN_WIDTH:
		p.x = -64
	fixed_1.set_pos(p)
	
	p = fixed_2.get_pos()
	p.x += FIXED_PROCESS_SPEED_PER_FRAME
	if p.x >= WIN_WIDTH:
		p.x = -64
	fixed_2.set_pos(p)

	


func _on_VisibilityNotifier2D_exit_screen():
	var p = byengine_1.get_pos()
	p.x = -64;
	byengine_1.set_pos(p)
#	print("It went out")
#	pass # replace with function body
