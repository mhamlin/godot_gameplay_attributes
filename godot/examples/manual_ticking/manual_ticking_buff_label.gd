extends Label


var runtime_buff: RuntimeBuff = null


func _ready() -> void:
	draw()


func draw() -> void:
	if runtime_buff:
		text = runtime_buff.buff.buff_name + " (will expire in " + String.num(runtime_buff.get_time_left(), 0) + " turns)"
