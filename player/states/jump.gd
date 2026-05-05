class_name PlayerStateJump extends PlayerState

var jump_hold_timer:float = 0.0
var jump_max_time = 0.8
var jump_force = -1000

func init() -> void:
	#print("p:",name)
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	pass
	
#退出状态实现的功能
func exit() ->void:
	pass
	
#处理输入
func handle_input(_event:InputEvent) -> PlayerState:
	if _event.is_action_released("jump") or jump_hold_timer >= jump_max_time:
		return idle
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(_delta:float) -> PlayerState:
	jump_hold_timer += _delta
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	
	if player.is_on_floor():
		player.velocity.y = player.jump_height
	else:
		player.velocity.y += jump_force * _delta
	
	return player_next_state
