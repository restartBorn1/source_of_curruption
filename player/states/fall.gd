class_name PlayerFallState extends PlayerState

#状态初始化
func init() -> void:
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.add_debug_indicator(Color.YELLOW)
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
	if player.is_on_floor():
		return idle
	#在下落状态时可以左右移动
	player.velocity.x = player.direction.x * player.move_speed
	return player_next_state
