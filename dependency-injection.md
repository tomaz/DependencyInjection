theme: Plain Jane, 7

# [fit] Ti dam, ti dam, ti dam ♫

# [fit] Dependency Injection

---

# DataStore

```swift
class DataStore {

	let shared = DataStore()

	private init() { }

	func performSomeCoolFunctionality() { }
}
```

---

# Singleton

```swift
class MasterViewController {
	// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// }
}

class ChildViewController {
	func doSomethingWithStore() {
		DataStore.shared.someCoolFunctionality()
	}
}
```

---

# Singleton

Pros:

- Simple to use
- No need to manage injection

Cons:

- Hard to maintain
- Hard to unit test
- Global state = 😈

---

# Lazy loading w/ singleton

```swift
class DataStore { ... }

protocol DataStoreConsumer {
	var dataStore: DataStore { get set }
}

extension DataStoreConsumer where Self: NSObject {
	var dataStore: DataStore {
		get {
			if let existing = objc_getAssociatedObject(self, &dataStoreKey) as? DataStore {
				return existing
			}
			return DataStore.shared
		}
		set {
			objc_setAssociatedObject(self, &dataStoreKey, newValue, .OBJC_ASSOCIATION_RETAIN)
		}
	}
}

private var dataStoreKey: UInt8 = 0
```

---

# Lazy loading w/ singleton

```swift
class MasterViewController {
	// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// }
}

class ChildViewController: DataStoreConsumer {
	func doSomethingWithStore() {
		dataStore.someCoolFunctionality()
	}
}
```

---

# Lazy loading w/ singleton

Pros:

- Access to singleton in single endpoint = simpler to change
- Possibility for injection (unit tests)
- Fallback to singleton if specific instance not provided

Cons:

- Halfbaked and inconsistent solution
- Possible incompatibility with future Swift version

^ Halfbaked because it's hard to trace all uses of singleton in various controllers/views when we actually need to inject
^ Possible future incompatibility: associated objects ability may be removed in future version of Swift

---

# [fit] What's left? Manual?? 
# [fit] Each dependency separately???

![inline](images/how.png)

---

# Naive manual implementation

```swift
class MasterViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.destination {
		case let destination as Child1ViewController:
			destination.dataStore = dataStore
		case let destination as Child2ViewController:
			destination.dataStore = dataStore
			destination.representedObject = anObject
		default:
			break
		}
	}
}
```

- Changes = 😱
- Repeating boiler-plate code
- Requires subclassing container controllers (`UINavigationController`...)

---

# Desired solution wishlist

```swift
class MasterViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		injectDependencies(to: segue.destination)
	}
}
```

- Injection method defined in single place
- Simple implementation in child controllers
- Container controllers treatment without subclassing

---

# Implementation

```swift
protocol DataStoreConsumer {
	var dataStore: DataStore! { get set }
}

class MasterViewController: DataStoreConsumer {
	var dataStore: DataStore!
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		injectDependencies(to: segue.destination)
	}
}

class ChildViewController: DataStoreConsumer {
	var dataStore: DataStore!
	func doSomethingWithStore() {
		dataStore.someCoolFunctionality()
	}
}
```

---

# Behind the scenes

```swift
extension NSObject {
	func injectDependencies(to controller: UIViewController) {
		controller.traverse { object in
			if let source = self as? DataStoreConsumer,
			   let destination = object as? DataStoreConsumer {
				destination.dataStore = source.dataStore
			}
		}
	}
}
```

- `NSObject` because extending `AnyObject` isn't allowed...
- `Provider` & `Consumer` protocols for more complex needs

---

# Behind the scenes - containers


```swift
extension UIViewController {
	func traverse(handler: (UIViewController) -> Void) {
		handler(self)
		for child in childViewControllers {
			child.traverse(handler: handler)
		}
	}
}
```

- Automatically jumps through container controllers

---

# DependencyInjection 

- Simple, extendible, DRY
- Unit testable and maintainable
- May require splitting for complex projects

##### `https://github.com/tomaz/DependencyInjection`

![inline](images/all-the-things.png)

---

# Questions?

### @tomsbarks

