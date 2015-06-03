# [fit] _Correct Behavior_
## through
# [fit] _Type Safety_

^ I want to talk today about some of the great things we can do with the new and improved type system that Swift brings to Cocoa development. For those used to the dynamic nature of Objective-C, Swift might seem like a setback—more akin to Java than the language we were using before.

^ However, I believe that Swift’s type system brings some much-needed safety to Cocoa development, helping us catch more bugs at compile-time, before they ship to and affect real users.

^ Specifically, static types allow us to _prove_ the correctness of certain things, and prevent many invalid states from even occurring. This talk will demonstrate some of the techniques for doing that, and show why testing alone isn't good enough.

---

# [fit] _@jspahrsummers_

## ReactiveCocoa
## Mantle
## Carthage

^ First, let me introduce myself. My name is Justin Spahr-Summers (@jspahrsummers on GitHub, Twitter, basically everything), and these are some of the open source projects I’ve been involved with.

^ When I'm not doing Cocoa development, I like to spend time with functional programming languages like Haskell, Idris, or Elm, which I've found really helpful for expanding my mind and learning powerful new concepts.

---

# TODO: BETTER TRANSITION

---

# [fit] **Curry–Howard**
# [fit] correspondence

^ … states that there is a relationship between type systems and logical proofs.

---

# [fit] _Types_ = _Proofs_

^ Specifically, that they are equivalent. A well-typed program is a logical proof, and a logical proof can be represented as a program.

^ Practically, this equivalence means (in a programming language with a type system) that each function must _prove_ its correctness to the typechecker and the compiler.

---

# A _→_ B

^ For example, in order for a function from type A to type B to compile, you must _prove_ that such a transformation is valid. This "proof" consists of writing a well-typed function definition.

---

# A _→_ B

```swift
func toInteger(num: Double) -> Int {
    let result = round(num)
    return Int(result)
}
```

^ Here's a function from `Double` to `Int`. The integer result _proves_ that we don't have a fractional component anymore.

^ There are a few valid implementations for this type signature. I picked the `round` function, but `floor` and `ceil` would also work. In all cases, though, executing the function gives you a _provably integral_ value as a result.

---

# [fit] String _→_ String

^ By contrast, the amount we can prove with this function is very little. You still have to prove that you have a `String` result, but there innumerable ways to implement this function that may be incorrect, or may not do anything at all!

---

# String _→_ String

```swift
func identity(s: String) -> String {
    return s
}
```

^ Here's a perfectly valid proof for the aforementioned type signature. This is a function from `String` to `String`, but we don't get much useful information from it.

---

# [fit] We can use
# _types_
# [fit] to prove
# _correctness_

^ The correspondence between types and proofs is useful because it means that having an instance of a given type _proves_ that you have performed a logically valid† transformation to obtain it.

---

# [fit] What does _NSData_ prove?
### **Not much.**

---

# [fit] What does _NSString_ prove?
### **_Characters_, not just bytes!**

^ Having a value of type `NSString` proves that you have "characters," not just a bundle of bytes.

---

# [fit] What does _NSURL_ prove?
### **_Valid URL_, not just a string!**

^ And having a value of type `NSURL` proves that you have a valid URL, not just an arbitrary string.

---

# Validation

TODO

^ This idea can be extended to any kind of validation.

---

`String`, `Int`, etc. allow all kinds of values

---

Creating a more restricted type (like an `enum`) proves that you have performed validation when you have it.

---

- When you parse JSON into custom models, this is simply a special case of validation!
- Having a validated model _proves more_ than the dictionaries, arrays, etc. that make up the JSON structure, which in turn proves more than the simple string (believed to contain JSON) before parsing

---

`NSArray` vs. `NSMutableArray`

^ The type of `NSArray` prevents you from mutating it.

---

`Optional` forces your code to acknowledge the possibility of `nil`

---

`Array<String>` prevents you from trying to insert or extract an `Int`

---

- C pointers can refer to anything in memory, even invalid addresses
- References (like Swift objects) can't be pointed to something invalid

---

# [fit] What about tests?

^ Proof vs. support, etc.

---

# [fit] Phantom types

- [Functional snippet #13](http://www.objc.io/snippets/13.html) from [objc.io](http://www.objc.io)
- [Validation with phantom types](https://wiki.haskell.org/Phantom_type) from the Haskell wiki

---

# [fit] Errors in ReactiveCocoa

---

- Historically three kinds of events:
    - Next
    - Error
    - Completed

- `RACSignal *` can send any number of `next`s, followed by `error` or `completed`

---

# [fit] Property binding in RAC 2

```
Screenshot and/or assertion failure (“error reached property binding”) goes here
```

---

- RAC doesn't know the answer
    - Ignoring the error might be appropriate for some cases, but not all
    - Framework trips an assertion because it doesn't know how to handle that case

---

# [fit] RAC 3

`Signal<T, Error: ErrorType>`

---

# `NoError`

---

# [fit] Property binding in RAC 3

```
Type of <~ goes here
```

---

# [fit] Types
# can also describe
# [fit] effects

^ In addition to adding safety, types can also describe some form of _unsafety_ or side effects

---

# [fit] `IO` in Haskell

~~Monads~~

^ Not important for this discussion.

---

# [fit] `IO` in Haskell

- You can put values into it
- You can do side-effecting operations with the values in it
- You cannot get the values out

^ In other words, seeing IO is a strong suggestion of side effects, and the absence of it is proof that there aren’t side effects†!

^ This is similar to Swift's `Optional`, which suggests that a value _might_ not exist—on the other hand, if you don't see `Optional`, the value definitely _does_ exist.

---

# [fit] RAC 3 (again)

`Signal` and `SignalProducer` describe _effects over time_

- You can put values into it
- You can do time-based operations with the values in it
- To get the values out, you have to register for delivery—you don't get them right away†

---

# [fit] Using types
# to capture
# [fit] threading

```
exaaaaaaaaaamppleeeeeessssssssssss
```

---

# Thanks

to all the lovely reviewers of this presentation: John Doe, Jane Doe, ???

---

# Questions?
