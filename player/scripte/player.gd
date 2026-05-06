class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICARORS = preload("uid://bhwji1cmxo7b5")

#region /// 导出变量
@export var move_speed:float = 125
#endregion

#region /// 状态机变量
var states:Array[PlayerState] #存储当前和历史的状态
var current_state: PlayerState: #获取当前状态
	get:return states.front()
var previous_state:PlayerState: #获取前一个状态
	get:return states[1]
#endregion

#region ///标准变量
var direction:Vector2 = Vector2.ZERO #方向变量
var gravity:float = 980.0 #重力
#endregion

func _ready() -> void:
	#初始化状态
	initialize_states()
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))

func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))

func _physics_process(_delta: float) -> void:
	velocity.y += gravity * _delta
	move_and_slide()
	
	change_state(current_state.physics_process(_delta))
	move_and_slide()

func initialize_states() -> void:
	states = []
	
	#收集所有状态
	for c in $states.get_children():
		if c is PlayerState:
			states.append(c)
			c.player = self
		pass
		
	#如果状态数组为空，就结束该函数
	if states.size() == 0:
		return
		
	#初始化所有状态
	for state in states:
		state.init()
		
	#设置初始状态
	change_state(current_state)
	current_state.enter()
	$Label.text = current_state.name
	
#改变状态
func change_state(new_state:PlayerState) -> void:
	#如果需要改变的新状态为空或者当新状态与当前状态相同时，结束函数
	if new_state == null:
		return
	if new_state == current_state:
		return
	
	#如果当前状态不为空，就退出该状态
	if current_state: 
		current_state.exit()
	
	#把新状态放入状态数组的第一个位置
	states.push_front(new_state)
	current_state.enter()
	$Label.text = current_state.name
	states.resize(3) #只保留3个状态，后面的状态将被剔除
	
func update_direction() -> void:
	#var prev_direction:Vector2 = direction
	
	var x_axis = Input.get_axis("left","right")
	var y_axis = Input.get_axis("up","down")
	direction = Vector2(x_axis,y_axis)
	
func add_debug_indicator(color:Color = Color.RED):
	var d:Node2D = DEBUG_JUMP_INDICARORS.instantiate()
	get_tree().root.add_child(d)
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(2.0).timeout
	d.queue_free()
