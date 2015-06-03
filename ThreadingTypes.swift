import Foundation

/// An arbitrary action that must be run on the main thread.
struct UIAction<T> {
	private let action: () -> T

	init(_ action: () -> T) {
		self.action = action
	}

	func enqueue() {
		return enqueue { _ in () }
	}

	func enqueue(handler: T -> ()) {
		dispatch_async(dispatch_get_main_queue()) {
			let result = self.action()
			handler(result)
		}
	}

	func map<U>(transform: T -> U) -> UIAction<U> {
		return UIAction<U> {
			return transform(self.action())
		}
	}

	func flatMap<U>(transform: T -> UIAction<U>) -> UIAction<U> {
		return UIAction<U> {
			let newAction = transform(self.action())
			return newAction.action()
		}
	}
}

let action = UIAction { println("foobar") }
action.enqueue()
