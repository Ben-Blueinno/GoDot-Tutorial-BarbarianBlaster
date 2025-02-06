extends Node3D

@export var max_hp: int = 5

var current_hp: int:
	set (hp):
		current_hp = hp
		print('hp was changed')
		label_3d.text = str(current_hp) + '/' + str(max_hp)
		var red = Color.RED
		var white = Color.WHITE
		label_3d.modulate = red.lerp(white, float(current_hp)/float(max_hp))
		if current_hp < 1:
			print('end')
			get_tree().reload_current_scene()
		
@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	current_hp = max_hp
	#Engine.time_scale = 10

func take_damage() -> void:
	print('base damaged')
	current_hp -= 1
	
