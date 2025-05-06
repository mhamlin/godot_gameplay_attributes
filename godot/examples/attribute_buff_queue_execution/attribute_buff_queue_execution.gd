extends HBoxContainer


const ENQUEUED_ONGOING_BUFF = preload("res://examples/attribute_buff_queue_execution/enqueued_ongoing_buff.tscn")


@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var parallel_button: Button = %ParallelButton
@onready var parallel_buffs_v_box_container: VBoxContainer = %ParallelBuffsVBoxContainer
@onready var waterfall_button: Button = %WaterfallButton
@onready var waterfall_buffs_v_box_container: VBoxContainer = %WaterfallBuffsVBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attribute_container.buff_dequeued.connect(handle_buff_dequeued)
	attribute_container.buff_enqueued.connect(handle_buff_enqueued)
	parallel_button.pressed.connect(create_buff_factory(AttributeBuff.QUEUE_EXECUTION_PARALLEL))
	waterfall_button.pressed.connect(create_buff_factory(AttributeBuff.QUEUE_EXECUTION_WATERFALL))


func create_buff_factory(buff_queue_execution_type: AttributeBuff.QueueExecution) -> Callable:
	return func handle_signal() -> void:
		var buff = AttributeBuff.new()

		buff.attribute_name = MaxHealthAttribute.ATTRIBUTE_NAME
		buff.buff_name = MaxHealthAttribute.ATTRIBUTE_NAME + "Buff"

		if buff_queue_execution_type == AttributeBuff.QUEUE_EXECUTION_PARALLEL:
			buff.buff_name += "Parallel"
		else:
			buff.buff_name += "Waterfall"
		buff.duration = 5.0
		buff.queue_execution = buff_queue_execution_type
		buff.transient = true
		buff.max_applies = 5

		attribute_container.apply_buff(buff)


func handle_buff_dequeued(runtime_buff: RuntimeBuff) -> void:
	if runtime_buff.buff.queue_execution == AttributeBuff.QUEUE_EXECUTION_PARALLEL:
		pop_first_child(parallel_buffs_v_box_container)
	else:
		pop_first_child(waterfall_buffs_v_box_container)


func handle_buff_enqueued(runtime_buff: RuntimeBuff) -> void:
	var item := ENQUEUED_ONGOING_BUFF.instantiate()

	if runtime_buff.buff.queue_execution == AttributeBuff.QUEUE_EXECUTION_PARALLEL:
		parallel_buffs_v_box_container.add_child(item)
	else:
		waterfall_buffs_v_box_container.add_child(item)

	item.configure(runtime_buff)


func pop_first_child(control: Control) -> void:
	var children = control.get_children()
	
	if children.size() > 0:
		children[0].queue_free()
