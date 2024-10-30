class_name ScrollCamera
extends PushBox

@export var top_left:Vector2 = Vector2(-15, -10)
@export var bottom_right:Vector2 = Vector2(15, 10)
@export var autoscroll_speed:float = 0.1

func _ready() -> void:
	box_width = bottom_right.x - top_left.x
	box_height = bottom_right.y - top_left.y
	super()

func _process(delta: float) -> void:
	if !current:
		return
	
	var tpos = target.global_position
	var cpos = global_position
	
	target.global_position.x += autoscroll_speed
	global_position.x += autoscroll_speed
	
	#left
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
	if diff_between_left_edges < 0:
		target.global_position.x -= diff_between_left_edges
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
	if diff_between_right_edges > 0:
		target.global_position.x -= diff_between_right_edges
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
	if diff_between_top_edges < 0:
		target.global_position.z -= diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
	if diff_between_bottom_edges > 0:
		target.global_position.z -= diff_between_bottom_edges
	
	super(delta)
