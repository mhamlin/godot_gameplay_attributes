extends ProgressBar


# we want the bar to be smooth without applying interpolation or similar stuff
const MULTIPLIER := 100.0


var runtime_buff: RuntimeBuff = null


func _physics_process(delta: float) -> void:
	value = runtime_buff.get_time_left() * MULTIPLIER


func configure(p_runtime_buff: RuntimeBuff) -> void:
	runtime_buff = p_runtime_buff
	max_value = runtime_buff.get_duration() * MULTIPLIER
	value = runtime_buff.get_time_left() * MULTIPLIER
