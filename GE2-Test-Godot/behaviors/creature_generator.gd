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
	var last_position = Vector3.ZERO
	for i in range(length):
		var size = gen_segment(i)
		var pos : Vector3
		if i != 0:
			pos = Vector3(last_position.z - abs(size), -size/2, -size/2)
		else:
			pos = Vector3(0, -size/2, -size/2)
			
		DebugDraw3D.draw_box(pos, Quaternion.IDENTITY, Vector3(size, size, size), Color(1, 0, 0))
		last_position.z = pos.z
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

