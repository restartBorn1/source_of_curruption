class_name Dash extends PlayerState

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
