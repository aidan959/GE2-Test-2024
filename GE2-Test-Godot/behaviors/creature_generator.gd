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
	if Engine.is_editor_hint() and draw_gizmos:	
		DebugDraw3D.clear_all()	
		do_draw_gizmos()
	pass


func do_draw_gizmos():
	var last_position = Vector3.ZERO
	for i in range(length):
		var angle = start_angle + i * 2 * PI / length  
		var size = base_size * (1 + sin(angle)) 
		DebugDraw3D.draw_box(Vector3(i,0,0),Quaternion.IDENTITY	, Vector3(size, size, size), Color(0, 1, 0) )

func _ready():
	if Engine.is_editor_hint() and draw_gizmos:		
		do_draw_gizmos()
	if not Engine.is_editor_hint():		
		for i in range(length):
			var angle = start_angle + i * 2 * PI / length  
			var size = base_size * (1 + sin(angle)) 
			var node = head_scene.instantiate()
			node.name = "Tail{0}".format(i)
			node.global_transform.origin.x = sin(angle * 1) 
			DebugDraw3D.draw_box(Vector3(i,0,0),Quaternion.IDENTITY, Vector3(size, size, size), Color(0, 1, 0) )
			add_child(node)
			print(sin(angle * i))	

	
	
	
	

func generate_worm():
	for i in range(length):
		var angle = start_angle + i * 2 * PI / length  
		var size = base_size * (1 + sin(angle)) 
		var node = head_scene.instance()
		node.name = "Tail{0}".format(i)
		node.scale = Vector3(size, size, size)  
		node.global_transform.origin.x = i  
		add_child(node)

