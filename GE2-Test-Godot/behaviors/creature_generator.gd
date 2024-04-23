@tool
extends Node3D

@export var length: int = 10
@export var frequency: float = 1.0
@export_range (0.0, 360.0) var start_angle = 0.0
@export var draw_gizmos: bool = true
@export var base_size: float = 1.0
@export var multiplier: float= 5.0
@export var head: PackedScene = preload("res://head.tscn")
@export var body_scene: PackedScene = preload("res://body_part.tscn")

var head_node: Boid 

func _process(_delta):
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
	if  draw_gizmos:		
		do_draw_gizmos()
	if not Engine.is_editor_hint():
		head_node = head.instantiate()
		$"../".add_child.call_deferred(head_node)
		head_node.pause = true
		generate_worm()


func gen_segment(i: int) -> float:
	var angle = start_angle + i * 2 * PI * frequency / length 
	var size = abs(base_size + sin(angle)) 
	return remap(size,0,1,0,multiplier)
	
	

func generate_worm():
	var size = gen_segment(0)
	var last_position: Vector3 = Vector3.ZERO
	last_position.z = abs(size)

	for i in range(length):
		size = gen_segment(i)/2
		last_position.x = 0
		last_position.y = 0
		var body_part = CSGBox3D.new()
		last_position.z -= size
		body_part.transform.origin = last_position
		body_part.size = Vector3(size, size, size)
		body_part.transform.origin = last_position
		head_node.add_child.call_deferred(body_part)
	


