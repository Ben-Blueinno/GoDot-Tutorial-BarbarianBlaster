extends Node3D

@export var projectile: PackedScene
@export var turrent_range := 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var turret_top: Node3D = $TurretBase/TurretTop
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var turret_base: MeshInstance3D = $TurretBase
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon

func _physics_process(_delta: float) -> void:
	target = find_next_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target:
		var shot = projectile.instantiate()
		add_child(shot)
		shot.global_position =  cannon.global_position
		shot.direction = turret_base.basis.z
		animation_player.play('Fire')

func find_next_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 4
	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var dis = global_position.distance_to(enemy.global_position)
			if dis <= turrent_range:
				if enemy.progress > best_progress:
					best_target = enemy
					best_progress = enemy.progress
	return best_target
