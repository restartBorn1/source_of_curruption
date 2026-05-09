class_name PlayerStateSquat extends PlayerState

@export var declaration_rate:float = 10

#状态初始化
func init() -> void:
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.animation_player.play("squat")
	player.collision_squat.disabled = false
	player.collision_stand.disabled = true
	pass
	
#退出状态实现的功能
func exit() ->void:
	player.collision_squat.disabled = true
	player.collision_stand.disabled = false
	pass
	
#处理输入
func handle_input(_event:InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		player.one_way_platform_shap_cast.force_shapecast_update()
		if player.one_way_platform_shap_cast.is_colliding():
			player.position.y += 4
			return fall
		return jump
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(_delta:float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * declaration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return player_next_state
