@icon( "res://player/states/state.svg" )
class_name PlayerState extends Node

var player:Player #引用玩家类
var player_next_state:PlayerState #存储玩家下一个状态的变量

#region /// 状态索引
#其他所有状态的引用索引
@onready var idle:PlayerState = %idle
@onready var run:PlayerState = %run
@onready var jump:PlayerState = %jump
@onready var dodge: Dodge = %dodge
@onready var dash: Dash = %dash
@onready var attack: Attack = %attack
@onready var fall: PlayerFallState = %fall
@onready var squat: PlayerStateSquat = %squat

#endregion

#状态初始化
func init() -> void:
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	pass
	
#退出状态实现的功能
func exit() ->void:
	pass
	
#处理输入
func handle_input(_event:InputEvent) -> PlayerState:
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(_delta:float) -> PlayerState:
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	return player_next_state
