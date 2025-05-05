How to apply damage using attributes
========================

Damage is the most common operation in games.

You could receive it by getting hit by a bullet, by falling from a cliff, 
or by being attacked by a monster and so on.

In this section, we will see two simple examples 
on how to apply damage using attribute buffs.

> prerequisite: follow the [First Steps](first-steps.md) tutorial to create the `HealthAttribute` and `MaxHealthAttribute` attributes.

## Example 1, the simple way

In this example we are going to create a simple damage buff that is going
to be applied to the `HealthAttribute` attribute.

The logic behind this is straightforward, we are going 
to create a `DamageBuff` class which exports a value (float) which is going 
to be subtracted from the `HealthAttribute` attribute.

```gdscript
class_name DamageBuff
extends AttributeBuff

@export var damage: float = 1.0

func _ready(_damage: float):
    attribute_name = HealthAttribute.ATTRIBUTE_NAME
    damage = _damage
    operation = AttributeOperation.sub(damage)
```

Apply the buff to the `HealthAttribute` attribute like this:

```gdscript
attribute_container.apply_buff(DamageBuff.new(10.0))
```

That's all folks!

## Example 2, the complex way

In certain games, you have multiple damage types, multiple resistances,
and multiple damage sources.

The logic (to handle the most complex cases) could sound awkward:
- you have to create, for each damage type you need, a damage attribute
- you have to assign these attributes to any attribute set you need (player, mobs, etc.). 
- you must not deal with damage directly to the health, instead you have to increase the damage attributes
- once an attribute changed, the [`AttributeContainer`](../classes/AttributeContainer.md) emits a `attribute_changed` signal.
- if the attribute changed is a damage attribute, you should apply a new attribute buff
  which is going to take care of calculating the proper damage, operating on health attribute and resetting the damage attribute(s) to 0.0.

## Example 2.1, a complex but less complex way

As the example above, but instead of handling damage as attributes, you
can export the damage type(s) and value(s) as a resource.
Once the buff
is applied, take those into consideration to determine how the buff can damage the health attribute.

