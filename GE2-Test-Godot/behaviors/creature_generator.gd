@tool
extends Node3D

@export var length: int = 10
@export var frequency: float = 1.0
@export_range (0.0, 360.0) var start_angle = 0.0
@export var draw_gizmos: bool = true
@export var base_size: float = 1.0
@export var multiplier: float= 5.0
@export var head: Boid = null
@export var body_scene: PackedScene = preload("res://body_part.tscn")

func _process(delta):
	if Engine.is_editor_hint() and draw_gizmos:	
		DebugDraw3D.clear_all()	
		do_draw_gizmos()
	pass


func do_draw_gizmos():
	var size = gen_segment(0)
	var last_position: Vector3 = Vector3.ZERO
	last_position.z = abs(size)/2
	for i in range(length):
		size = gen_segment(i)
		last_position.x = -size/2
		last_position.y = -size/2
	
		last_position.z -= abs(size)
		DebugDraw3D.draw_box(last_position, Quaternion.IDENTITY, Vector3(size, size, size), Color(1, 1, 0))

func _ready():
	if Engine.is_editor_hint() and draw_gizmos:		
		do_draw_gizmos()
	if not Engine.is_editor_hint():		
		generate_worm()	

func gen_segment(i: int) -> float:
	var angle = start_angle + i * 2 * PI * frequency / length 
	var size = abs(base_size + sin(angle) * (multiplier)) 
	return size
	
	

func generate_worm():
	var last_position = Vector3.ZERO
	for i in range(length):
		var size = gen_segment(i)
		var body_part = body_scene.instantiate()
		var csg : CSGBox3D = body_part.get_child(0)
		var node_size = Vector3(size, size, size)  
		csg.size = node_size
		body_part.global_transform.origin = last_position
		head.call_deferred("add_child", body_part)
		last_position.z -= abs(size)

