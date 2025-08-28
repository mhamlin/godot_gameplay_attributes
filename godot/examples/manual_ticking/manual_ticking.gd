extends Control

const ManualTickingBuffLabel = preload("uid://c1g42dnwl5xxp")
const TEST_ATTRIBUTE_NAME := LevelAttribute.ATTRIBUTE_NAME


@onready var apply_buff_button: Button = %ApplyBuffButton
@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var attribute_value_label: Label = %AttributeValueLabel
@onready var buffs_v_box_container: VBoxContainer = %BuffsVBoxContainer
@onready var end_turn_button: Button = %EndTurnButton
@onready var turn_duration_spin_box: SpinBox = %TurnDurationSpinBox


func _ready() -> void:
	attribute_container.apply_buff(InitializeAttributes.new())

	attribute_container.buff_applied.connect(func (runtime_buff: RuntimeBuff):
		var buff_label := ManualTickingBuffLabel.new()

		buff_label.runtime_buff = runtime_buff
		
		buffs_v_box_container.add_child(buff_label)
		
		update_attribute_value_label()
	)
	
	attribute_container.buff_time_elapsed.connect(func (_runtime_buff):
		for child in buffs_v_box_container.get_children():
			child.draw()
	)

	attribute_container.buff_removed.connect(func (runtime_buff: RuntimeBuff):
		for child in buffs_v_box_container.get_children():
			if child.runtime_buff == runtime_buff:
				child.queue_free()
	)

	apply_buff_button.pressed.connect(func ():
		var buff := TheBuff.new()
		buff.duration = turn_duration_spin_box.value
		attribute_container.apply_buff(buff)	
	)
	
	end_turn_button.pressed.connect(end_turn)
	
	update_attribute_value_label()


func end_turn() -> void:
	attribute_container.set_tick(1.0)
	
	
func update_attribute_value_label() -> void:
	attribute_value_label.text = TEST_ATTRIBUTE_NAME + " " + String.num(attribute_container.get_attribute_buffed_value_by_name(TEST_ATTRIBUTE_NAME), 0)
	

class TheBuff extends AttributeBuff:
	func _init() -> void:
		attribute_name = TEST_ATTRIBUTE_NAME # that's just for the sake of the example
		buff_name = "Turn based buff"
		duration = 3.0 # the default number of turns 
		operation = AttributeOperation.add(1.0)
		transient = true
