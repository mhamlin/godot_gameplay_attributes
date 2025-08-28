Turn based attribute buffs
==========================

> This is straightforward.

To handle turn-based buffs, you need two things:

- You have to mark your `AttributeBuff` as `transient` and give it an integer `duration`.
- You have to activate the `AttributeContainer` `manual_ticking` flag to `true`.

When you apply an `AttributeBuff`, the time left for the buff will not be altered in any way until you will call `AttributeContainer.set_tick()`.

`AttributeContainer.set_tick()` will then decrement the `duration` of all `AttributeBuff`s that have a `duration` greater than `0` by the specified `tick` value.

You can refer to this example to see this in action:

[manual_ticking](../../godot/examples/manual_ticking)