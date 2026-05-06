class_name PlayerStateIdle extends PlayerState


func init() -> void:
	#print("p:",name)
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.add_debug_indicator(Color.RED)
	pass
	
#退出状态实现的功能
func exit() ->void:
	pass
	
#处理输入
func handle_input(_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(_delta:float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
			return fall
	return player_next_state
