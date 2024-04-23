@tool
extends Node3D

@export var length: int = 10
@export var frequency: float = 1.0
@export_range (0.0, 360.0) var start_angle = 0.0
@export var draw_gizmos: bool = true
@export var base_size: float = 1.0
@export var multiplier: float= 5.0
@export var head_scene: PackedScene = null

func _process(delta):
	pass
	


func do_draw_gizmos():
	for i in range(length):
		var angle = start_angle + sin(deg_to_rad(i) )
		var size = base_size * pow(multiplier, i)
		#var node = head_scene.instantiate()
		#node.name = "Tail{0}".format(i)
		# node.global_transform.origin.x = sin(angle * 1) 
		DebugDraw3D.draw_box(Vector3(i,0,0),Quaternion.IDENTITY	, Vector3(size, size, size), Color(0, 1, 0) )
		# add_child(node)
		# print(sin(angle * i))

func _ready():
	if Engine.is_editor_hint() and draw_gizmos:		
		do_draw_gizmos()
	if not Engine.is_editor_hint():		
		for i in range(length):
			var angle = start_angle + sin(deg_to_rad(i) )
			var size = base_size * pow(multiplier, i)
			var node = head_scene.instantiate()
			node.name = "Tail{0}".format(i)
			node.global_transform.origin.x = sin(angle * 1) 
			DebugDraw3D.draw_box(Vector3(i,0,0),Quaternion.IDENTITY, Vector3(size, size, size), Color(0, 1, 0) )
			add_child(node)
			print(sin(angle * i))	

	
	
	
	



