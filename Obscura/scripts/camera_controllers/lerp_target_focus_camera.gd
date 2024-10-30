class_name LerpTargetFocusCamera
extends LerpCamera

@export var lead_speed:float = 1.9
@export var catchup_delay_duration:float = 0.2
var x_idle:bool = false
var z_idle:bool = false
var timer_x
var timer_z

func _ready() -> void:
	follow_speed = lead_speed
	timer_x = add_timer()
	timer_z = add_timer()
	super()

func add_timer():
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = catchup_speed
	add_child(timer)
	return timer

func update(delta, direction):
	if !current:
		return
	
	if direction.x == 0:
		if !x_idle:
			x_idle = true
			timer_x.start(catchup_delay_duration)
		elif timer_x.time_left == 0: catch_up_x(direction)
	else: x_idle = false
	if direction.z == 0:
		if !z_idle:
			z_idle = true
			timer_z.start(catchup_delay_duration)
		elif timer_z.time_left == 0: catch_up_z(direction)
	else: z_idle = false
	
	follow(delta, direction)
