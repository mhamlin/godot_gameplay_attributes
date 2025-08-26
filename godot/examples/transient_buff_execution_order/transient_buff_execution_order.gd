extends Control


enum ExampleOperation {
	ADD,
	SUB,
	MUL,
	DIV,
	PERC,
}


const ATTRIBUTE_NAME := "TestThisAttributePineappleOnPizzaIsForbidden"


@onready var attribute_container: AttributeContainer = $AttributeContainer
@onready var buff_value_result: Label = %BuffValueResult
@onready var buff_value_spin_box: SpinBox = %BuffValueSpinBox
@onready var add_button: Button = %AddButton
@onready var sub_button: Button = %SubButton
@onready var mul_button: Button = %MulButton
@onready var div_button: Button = %DivButton
@onready var perc_button: Button = %PercButton
@onready var reset_button: Button = %ResetButton
@onready var operations_v_box_container: VBoxContainer = %OperationsVBoxContainer


func _ready() -> void:
	var attribute = Attribute.new()
	attribute.attribute_name = ATTRIBUTE_NAME
	attribute_container.attribute_set = AttributeSet.new()
	attribute_container.attribute_set.add_attribute(attribute)
	
	attribute_container.setup()
	
	add_button.pressed.connect(buff_create_function_factory(ExampleOperation.ADD))
	sub_button.pressed.connect(buff_create_function_factory(ExampleOperation.SUB))
	mul_button.pressed.connect(buff_create_function_factory(ExampleOperation.MUL))
	div_button.pressed.connect(buff_create_function_factory(ExampleOperation.DIV))
	perc_button.pressed.connect(buff_create_function_factory(ExampleOperation.PERC))
	
	attribute_container.buff_applied.connect(func (runtime_buff: RuntimeBuff) -> void:
		add_buff_label(runtime_buff)
		update_value_label()
	)
	
	reset_button.pressed.connect(reset)

	update_value_label()


func add_buff_label(runtime_buff: RuntimeBuff) -> void:
	var label = Label.new()
	
	match runtime_buff.buff.operation.operand:
		runtime_buff.buff.operation.OP_ADD:
			label.text += "+"
		runtime_buff.buff.operation.OP_DIVIDE:
			label.text += "/"
		runtime_buff.buff.operation.OP_MULTIPLY:
			label.text += "*"
		runtime_buff.buff.operation.OP_PERCENTAGE:
			label.text += "%"
		runtime_buff.buff.operation.OP_SUBTRACT:
			label.text += "-"
	
	label.text += String.num(runtime_buff.buff.operation.value, 2)
	operations_v_box_container.add_child(label)


func buff_create_function_factory(operator: ExampleOperation) -> Callable:
	return func apply_buff() -> void:
		if absf(buff_value_spin_box.value - 0.0001) < 0.0:
			return
		
		var buff = AttributeBuff.new()
		
		buff.attribute_name = ATTRIBUTE_NAME
		buff.transient = true
		
		match operator:
			ExampleOperation.ADD:
				buff.operation = AttributeOperation.add(buff_value_spin_box.value)
			ExampleOperation.SUB:
				buff.operation = AttributeOperation.subtract(buff_value_spin_box.value)
			ExampleOperation.MUL:
				buff.operation = AttributeOperation.multiply(buff_value_spin_box.value)
			ExampleOperation.DIV:
				buff.operation = AttributeOperation.divide(buff_value_spin_box.value)
			ExampleOperation.PERC:
				buff.operation = AttributeOperation.percentage(buff_value_spin_box.value)

		attribute_container.apply_buff(buff)


func reset() -> void:
	attribute_container.get_attribute_by_name(ATTRIBUTE_NAME).clear_buffs()
	buff_value_spin_box.value = 0
	
	for child in operations_v_box_container.get_children():
		child.queue_free()

	update_value_label()


func update_value_label() -> void:
	buff_value_result.text = String.num(attribute_container.get_attribute_buffed_value_by_name(ATTRIBUTE_NAME), 2)	
