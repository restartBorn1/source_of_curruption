class_name PlayerStateRun extends PlayerState



func init() -> void:
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.animation_player.play("run")
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
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return squat
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return player_next_state
