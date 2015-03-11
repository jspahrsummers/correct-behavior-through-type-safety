# Correct Behavior Through Type Safety

Swift has brought a much stronger type system to Cocoa development, which helps catch more bugs at compile-time, before they ship and affect real users.

But it’s not enough to bring Objective-C patterns to Swift, sprinkle in a few types, and call it done. With a more powerful type system, we are now able to prevent many more invalid states from ever occurring, and can use new patterns for statically ensuring the correctness of our programs.

This talk will explain how types can be used to ensure correctness, how to prevent the existence of invalid states, and why unit tests are not enough. Finally, we’ll dive into some specific approaches to correctness that will take advantage of Swift’s strong type system.
