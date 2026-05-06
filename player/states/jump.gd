class_name PlayerStateJump extends PlayerState

@export var jump_velocity:float = 450 #跳跃速度

func init() -> void:
	#print("p:",name)
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.velocity.y -= jump_velocity
	player.add_debug_indicator(Color.LIME_GREEN)
	pass
	
#退出状态实现的功能
func exit() ->void:
	pass
	
#处理输入
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_released("jump"):
		player.velocity.y *= 0.5
		return fall
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(_delta:float) -> PlayerState:
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	elif player.velocity.y >= 0:
		return fall
	
	#在跳跃状态时可以左右移动
	player.velocity.x = player.direction.x * player.move_speed
	return player_next_state
