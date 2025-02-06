extends Camera3D

@export var gridmap: GridMap
@export var turret_manager: Node3D
@export var turret_cost = 100

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank = get_tree().get_first_node_in_group('bank')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var mosue_pos: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mosue_pos) * 100.0
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding():
		if bank.gold >= 100:
			var collider = ray_cast_3d.get_collider()
			if collider is GridMap:
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
				if Input.is_action_pressed("click"):
					var collider_point = ray_cast_3d.get_collision_point()
					var cell = gridmap.local_to_map(collider_point)
					if gridmap.get_cell_item(cell) == 0:
						gridmap.set_cell_item(cell, 1)
						var tile_pos = gridmap.map_to_local(cell)
						turret_manager.build_turret(tile_pos)
						bank.gold -= turret_cost
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			
