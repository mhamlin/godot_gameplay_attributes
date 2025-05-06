extends Control

@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var infinite_stack_button: Button = %InfiniteStackButton
@onready var max_stack_count_label: Label = %MaxStackCountLabel
@onready var max_stack_button: Button = %MaxStackButton
@onready var remove_max_stack_button: Button = %RemoveMaxStackButton
@onready var remove_infinite_stack_button: Button = %RemoveInfiniteStackButton
@onready var stack_count_label: Label = %StackCountLabel
@onready var time_left_label: Label = %TimeLeftLabel
@onready var time_reset_button: Button = %TimeResetButton
@onready var unique_buff_count_label: Label = %UniqueBuffCountLabel
@onready var unique_buff_button: Button = %UniqueBuffButton
@onready var remove_unique_buff_button: Button = %RemoveUniqueBuffButton


func _ready() -> void:
	max_stack_button.pressed.connect(func ():
		attribute_container.apply_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.MaxStackCount))
	)
	
	remove_max_stack_button.pressed.connect(func ():
		attribute_container.remove_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.MaxStackCount))	
	)
	
	infinite_stack_button.pressed.connect(func ():
		attribute_container.apply_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.InfiniteStack))
	)
	
	remove_infinite_stack_button.pressed.connect(func ():
		attribute_container.remove_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.InfiniteStack))
	)
	
	time_reset_button.pressed.connect(func ():
		attribute_container.apply_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.TimeReset))
	)
	
	unique_buff_button.pressed.connect(func ():
		attribute_container.apply_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.UniqueBuff))	
	)
	
	remove_unique_buff_button.pressed.connect(func ():
		attribute_container.remove_buff(make_buff(AttributeBuffStackingExample.ExampleBuffType.UniqueBuff))	
	)
	
	attribute_container.buff_applied.connect(make_draw_buff("Buff applied: "))
	attribute_container.buff_removed.connect(make_draw_buff("Buff removed: "))
	
	attribute_container.buff_enqueued.connect(func (buff: RuntimeBuff):
		print("Buff {0} enqueued".format({
			0: buff.get_buff_name()
		}))
	)
	
	attribute_container.buff_dequeued.connect(func (buff: RuntimeBuff):
		print("Buff {0} dequeued".format({
			0: buff.get_buff_name()
		}))
	)
	
	attribute_container.buff_time_elapsed.connect(func (buff: RuntimeBuff):
		time_left_label.text = String.num(buff.get_time_left(), 2) + "s"
	)
	
	attribute_container.buff_time_updated.connect(func (buff: RuntimeBuff):
		print("time left updated for buff " + buff.buff.buff_name)	
		time_left_label.text = String.num(buff.get_time_left(), 2) + "s"
	)


func make_draw_buff(buff_message: String) -> Callable:
	return func draw_buff(buff: RuntimeBuff):
		var related_attribute := attribute_container.get_attribute_by_name(buff.get_attribute_name())
		var buffs = related_attribute.get_buffs().filter(func (x: RuntimeBuff): return x.get_buff_name() == buff.get_buff_name())

		print("{0} {1}".format({0: buff_message, 1: buff.get_buff_name()}))

		match buff.get_buff_name():
			AttributeBuffStackingExample.names[AttributeBuffStackingExample.ExampleBuffType.MaxStackCount]:
				max_stack_count_label.text = String.num(buffs.size(), 0) + "/" + String.num(make_buff(AttributeBuffStackingExample.ExampleBuffType.MaxStackCount).stack_size, 0)
			AttributeBuffStackingExample.names[AttributeBuffStackingExample.ExampleBuffType.InfiniteStack]:
				stack_count_label.text = String.num(buffs.size(), 0)
			AttributeBuffStackingExample.names[AttributeBuffStackingExample.ExampleBuffType.TimeReset]:
				time_left_label.text = String.num(buff.get_time_left(), 2)
			AttributeBuffStackingExample.names[AttributeBuffStackingExample.ExampleBuffType.UniqueBuff]:
				unique_buff_count_label.text = String.num(buffs.size(), 0) + "/1"


func make_buff(type: AttributeBuffStackingExample.ExampleBuffType):
	var buff = AttributeBuffStackingExample.new()
	buff.buff_type = type
	return buff
