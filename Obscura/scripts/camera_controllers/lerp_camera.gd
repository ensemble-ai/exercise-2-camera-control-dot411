class_name LerpCamera
extends PushBox

@export var follow_speed:float = 0.1
@export var catchup_speed:float = 0.1
@export var leash_distance:float = 3
var direction: Vector2 = Vector2(0, 0)

func _ready() -> void:
	super()
	target.connect("moving", update)

func catch_up_x(direction):
	if direction.x == 0: global_position.x = lerp(global_position.x, target.global_position.x, catchup_speed)

func catch_up_z(direction):
	if direction.z == 0: global_position.z = lerp(global_position.z, target.global_position.z, catchup_speed)

func follow(delta, direction):
	global_position += target.velocity * delta * follow_speed
	var dx = target.global_position.x - global_position.x
	var dz = target.global_position.z - global_position.z
	if sqrt(dx*dx + dz*dz) > 3: global_position += target.velocity * delta * (1 - follow_speed)

func update(delta, direction):
	if !current:
		return
		
	catch_up_x(direction)
	catch_up_z(direction)
	follow(delta, direction)
