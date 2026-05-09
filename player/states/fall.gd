class_name PlayerFallState extends PlayerState

@export var coyote_time:float = 0.1
@export var fall_gravity_multiplier = 1.165 #坠落时的重力乘数
@export var jump_buffer_time:float = 0.1
var coyote_timer:float = 0
var jump_buffer_timer = 0

#状态初始化
func init() -> void:
	pass
	
#进入某个状态实现的功能
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.add_debug_indicator(Color.YELLOW)
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass
	
#退出状态实现的功能
func exit() ->void:
	player.gravity_multiplier = 1.0
	pass
	
#处理输入
func handle_input(event:InputEvent) -> PlayerState:
	if event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else:
			jump_buffer_timer = jump_buffer_time
	return player_next_state

#特定状态的处理函数，用于Player类的处理函数调用
func process(delta:float) -> PlayerState:
	set_fall_frame()
	coyote_timer -= delta
	jump_buffer_timer -= delta
	return player_next_state
	
#特定状态的物理处理函数，用于Player类的物理处理函数调用
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		if jump_buffer_timer > 0:
			return jump
		return idle
	#在下落状态时可以左右移动
	player.velocity.x = player.direction.x * player.move_speed
	return player_next_state
	
func set_fall_frame() -> void:
	var frame:float = remap(player.velocity.y,0.0,player.max_fall_velocity,0.5,1.0)
	player.animation_player.seek(frame,true)
	pass
