AttributeContainer
=================

defined in `src/attribute_container.hpp`

## Description

The core of the system. This is the only node available in the addon.

It is used to store one attribute set and to compute the value of the attributes.

You can place this node wherever you want in your scene tree. 

## Members

- `attribute_set`: The attribute set used to store the attributes.
- `manual_ticking`: If set to true, `AttributeBuff` duration is going to be handled by you.

## Signals

- `attribute_changed`: emitted when an attribute changes.
- `buff_applied`: emitted when a buff (transient) is applied.
- `buff_dequed`: emitted when a buff (transient and with duration) is dequeued.
- `buff_enqueued`: emitted when a buff (transient and with duration) is enqueued.
- `buff_removed`: emitted when a buff (transient) is removed.
- `buff_time_elapsed`: emitted when a buff (transient and with duration) time is elapsed.
- `buff_time_updated`: emitted when a buff (transient and with duration) time is updated or restarted.

## Methods

- `add_attribute`: adds an [`Attribute`](Attribute.md) to the attribute container dynamically.
- `apply_buff`: applies an [`AttributeBuff`](AttributeBuff.md) to the attribute container.
- `count_buffs`: counts the number of [`AttributeBuff`](AttributeBuff.md) in the attribute container.
This function accepts a `Callable`, a `String` or an `AttributeBuff` as a parameter.
- `find`: finds a [`RuntimeAttribute`](RuntimeAttribute.md) by name or with a `Callable`.
- `find_buffed_value`: finds a [`RuntimeAttribute`](RuntimeAttribute.md) by name or with a `Callable` and returns its buffed value.
- `find_value`: finds a [`RuntimeAttribute`](RuntimeAttribute.md) by name or with a `Callable` and returns its value (the one without `transient` [`AttributeBuff`](AttributeBuff.md) buffs applied).
- `get_attributes`: gets all the attributes in the attribute container.
- `get_attribute_by_name`: gets an [`Attribute`](Attribute.md) by name.
- `get_attribute_buffed_value_by_name`: gets a [`RuntimeAttribute`](RuntimeAttribute.md) by name and returns its buffed value.
- `get_attribute_value_by_name`: gets a [`RuntimeAttribute`](RuntimeAttribute.md) by name and returns its value (the one without `transient` [`AttributeBuff`](AttributeBuff.md) buffs applied).
- `remove_attribute`: removes an [`Attribute`](Attribute.md) from the attribute container. This also will remove the `RuntimeAttribute` from the container.
- `remove_buff`: removes an [`AttributeBuff`](AttributeBuff.md) from the attribute container.
- `setup`: sets up the attribute container. This will create the `RuntimeAttribute` for each attribute in the attribute set.
- `set_tick`: Sets the tick manually. The value passed is subtracted from transient AttributeBuff durations

[Back to classes](README.md)
