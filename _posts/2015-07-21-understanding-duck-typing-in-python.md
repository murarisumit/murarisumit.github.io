---
title: Understanding duck typing in python
date: 2015-07-21 00:00:00
layout: post
tags:
  - Python
---


I was trying to understand what duck typing in python, but what I understood was simple.

Duck Typing is an **After the Fact** assessment whereas Static Typing is a **Before the Fact** assessment. In static typing, we can achieve in two ways – via an interface or a class.

A class will state what an instance or its children will have. With an interface, it states what something *can* be at least in part. Both of these determinations can be made before they exist. **With Duck Typing, we only know what something is until after it has been created.**

In a duck type world, if I have all of your members, we are of the same type. I may have additional members, which makes me a more specialised type of you – but we are still of the same type. In the OO world, to be of the same type, we have to share some common lineage, either via a class or interface inheritance(type-casting).

So for java people, it's \*\* type-casting\*\* on runtime not on compile time(which is done by interface implementation).

A good analogy is this. In the old days of the British Aristocracy, to be *of* them, you had to be born into it (inherited). Even if you had as much money, property, an estate, etc (AKA you looked like them) – you would never be of them. But if it was a duck type world, then you would be of them since you had all the same semantics.

So if a method needs a object of type "duck" but receive a some other object but has the same properties, then it can be typecasted without error.

In static type system.

```
class Duck
{
  public void Quack() { ... }
  public void Walk() { ... }
}

class OtherDuck
{
  public void Quack() { ... }
  public void Walk() { ... }
}
...
void M(Duck bird)
{
  bird.Quack();
  bird.Walk();
}
...
M(new Duck()); // Legal
M(new OtherDuck()); // Illegal
```

but in duck-typed language.

```
void N(ducktyped bird)
{
  bird.Quack();
  bird.Walk();
}
N(new Duck()); // Legal
N(new OtherDuck()); // Legal!
N(123); // Illegal!
```

it's legal bacause Because `If it WalksLikeaDuck and talks like a duck, it must be a duck`

So in python

```
def f(x):
    x.Quak()
#if gets an x supporting a Quak(), everything is fine, if not, it will crash at runtime.
```

Handling duck typing in python

```
try:
    dog.quack()  #work it has quak, else throw Exception
except AttributeError:
    dog.woof()
```

Reference: [http://ericlippert.com/2014/01/02/what-is-duck-typing](http://ericlippert.com/2014/01/02/what-is-duck-typing)