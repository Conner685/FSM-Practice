class_name Enemy
extends CharacterBody2D

@export var max_speed = 40.0
@export var acceleration = 100.0

@onready var ray_cast_2d = $RayCast2D
@onready var enemy_wander_state = $FiniteStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var fsm = $FiniteStateMachine as FiniteStateMachine

func _ready():
	enemy_wander_state.saw_player.connect(fsm.change_state.bind(enemy_chase_state))
	enemy_chase_state.lost_player.connect(fsm.change_state.bind(enemy_wander_state))

func _physics_process(delta):
	ray_cast_2d.target_position = get_local_mouse_position()
