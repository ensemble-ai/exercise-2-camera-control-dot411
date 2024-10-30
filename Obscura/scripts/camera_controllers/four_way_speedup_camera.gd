class_name FourWaySpeedupCamera
extends PushBox

@export var push_ratio:float = 0.5
@export var pushbox_top_left:Vector2 = Vector2(-30, -20)
@export var pushbox_bottom_right:Vector2 = Vector2(30, 20)
@export var speedup_zone_top_left:Vector2 = Vector2(-15, -10)
@export var speedup_zone_bottom_right:Vector2 = Vector2(15, 10)
var inner_box_width:float
var inner_box_height:float

func _ready() -> void:
	box_width = pushbox_bottom_right.x - pushbox_top_left.x
	box_height = pushbox_bottom_right.y - pushbox_top_left.y
	inner_box_width = speedup_zone_bottom_right.x - speedup_zone_top_left.x
	inner_box_height = speedup_zone_bottom_right.y - speedup_zone_top_left.y
	super()

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic: draw_inner_box()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#left
	if target.velocity.x < 0:
		var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - box_width / 2.0)
		var diff_between_left_edges_inner = (tpos.x + target.WIDTH / 2.0) - (cpos.x - inner_box_width / 2.0)
		if diff_between_left_edges > 0 and diff_between_left_edges_inner < 0:
			global_position.x += target.velocity.x * delta * push_ratio
	#right
	if target.velocity.x > 0:
		var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + box_width / 2.0)
		var diff_between_right_edges_inner = (tpos.x + target.WIDTH / 2.0) - (cpos.x + inner_box_width / 2.0)
		if diff_between_right_edges < 0 and diff_between_right_edges_inner > 0:
			global_position.x += target.velocity.x * delta * push_ratio
	#top
	if target.velocity.z < 0:
		var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - box_height / 2.0)
		var diff_between_top_edges_inner = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - inner_box_height / 2.0)
		if diff_between_top_edges > 0 and diff_between_top_edges_inner < 0:
			global_position.z += target.velocity.z * delta * push_ratio
	#bottom
	if target.velocity.z > 0:
		var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + box_height / 2.0)
		var diff_between_bottom_edges_inner = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + inner_box_height / 2.0)
		if diff_between_bottom_edges < 0 and diff_between_bottom_edges_inner > 0:
			global_position.z += target.velocity.z * delta * push_ratio
	
	super(delta)

func draw_inner_box() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -inner_box_width / 2
	var right:float = inner_box_width / 2
	var top:float = -inner_box_height / 2
	var bottom:float = inner_box_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
