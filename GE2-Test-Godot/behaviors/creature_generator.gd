@tool
extends Node3D

@export var length: int = 10
@export var frequency: float = 1.0
@export_range (0.0, 360.0) var angle = 0.0

@export var base_size: float = 1.0
@export var multiplier: float= 5.0
@export var head_scene: PackedScene = null

func _process(delta):
	pass		

func _ready():
	if not Engine.is_editor_hint():		
		pass

	for i in length:
		var node = head_scene.instantiate()
		node.name = "Tail{0}".format(i)
		add_child(node)
		
		node.global_transform.origin.x = sin(angle * 1) 
		print(sin(angle * i))
	
	
	



