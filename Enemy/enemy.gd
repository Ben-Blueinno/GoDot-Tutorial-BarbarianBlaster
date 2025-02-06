extends PathFollow3D

@export var speed: float = 2.5
@export var max_hp: int = 50

@onready var base = get_tree().get_first_node_in_group('base')
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group('bank')

var current_hp: int:
	set(hp_in):
		if hp_in < current_hp:
			animation_player.play('TakeDamage')
		current_hp = hp_in
		if current_hp < 1:
			bank.gold += 15
			queue_free()
			
func _ready() -> void:
	current_hp = max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)
		queue_free()
	
