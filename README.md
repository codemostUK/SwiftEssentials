# SwiftEssentials

A modular toolkit of reusable components, extensions, and utilities to accelerate iOS development. SwiftEssentials provides essential building blocks to streamline workflows, reduce boilerplate, and maintain clean, scalable codebases.

![Build Status](https://img.shields.io/github/workflow/status/codemostUK/SwiftEssentials/CI) 
![Swift Version](https://img.shields.io/badge/swift-5.5%2B-orange.svg)
![License](https://img.shields.io/github/license/codemostUK/SwiftEssentials)

---

## 🚀 Features

- Reusable custom UIKit components (e.g., animated image view, loading button)
- Useful Foundation and UIKit extensions
- Built-in helpers for common tasks
- Table data rendering abstraction

---

## 📦 Installation

### Swift Package Manager

```swift
.package(url: "https://github.com/codemostUK/SwiftEssentials.git", from: "1.0.0")
```

### CocoaPods

```ruby
pod 'SwiftEssentials', '~> 1.0'
```

---

## 📁 Folder Structure

```
Sources/
 ├── Classes/               # Custom UI components
 ├── Extensions/            # UIKit + Foundation extensions
 ├── Helpers/               # Utilities and controllers
 ├── PropertyWrapper/       # Codable wrappers
 ├── Protocols/             # Shared protocols
 └── Views/                 # Miscellaneous view utilities
```

---

## 🧪 Usage Examples

### 🔹 SECircularCountDownView

```swift
import SwiftEssentials

let countDownView = SECircularCountDownView()
countDownView.duration = 60 // 60 seconds
countDownView.start()
```

---

### 🔹 SEAnimatedImageView

```swift
import SwiftEssentials

let animatedImageView = SEAnimatedImageView()
animatedImageView.imageName = "mySprite"
animatedImageView.frameCount = 12
animatedImageView.duration = 1.5
animatedImageView.startAnimation()
```

---

### 🔹 SELoadingButton

```swift
import SwiftEssentials

let button = SELoadingButton()
button.showLoading()
// perform async task
button.hideLoading()
```

---

### 🔹 SEUILabel

```swift
import SwiftEssentials

let label = SEUILabel()
label.letterSpacing = 1.2
label.lineHeight = 24
label.text = "Styled text"
```

---

### 🔹 FormValidator

```swift
import SwiftEssentials

let validator = FormValidator()
validator.add(field: emailField, rules: [.required, .email])
validator.add(field: passwordField, rules: [.required, .minLength(6)])

if validator.validate() {
    // proceed
} else {
    print(validator.errors)
}
```

---

### 🔹 EmptyTableRenderer

```swift
import SwiftEssentials

tableView.backgroundView = EmptyTableRenderer.create(message: "No data available")
```

---

## 🔧 Helper Usage Examples

### 🔹 FormValidator

```swift
import SwiftEssentials

let validator = FormValidator()
validator.add(field: emailField, rules: [.required, .email])
validator.add(field: passwordField, rules: [.required, .minLength(6)])

if validator.validate() {
    // proceed
} else {
    print(validator.errors)
}
```

---

### 🔹 ExpandableByKeyboardController

```swift
import SwiftEssentials

let keyboardController = ExpandableByKeyboardController(containerView: yourView)
keyboardController.startObserving()
// Don’t forget to call `stopObserving()` on deinit
```

---

### 🔹 DeviceInfo

```swift
import SwiftEssentials

print(DeviceInfo.isSimulator)      // true or false
print(DeviceInfo.deviceModel)      // e.g. "iPhone15,2"
```

---

### 🔹 PaginatedList

```swift
import SwiftEssentials

var list = PaginatedList<String>()
list.append(contentsOf: ["A", "B", "C"])
list.currentPage = 2
list.hasMorePages = true
```

---

### 🔹 SEImageCompressor

```swift
import SwiftEssentials

if let compressedImageData = SEImageCompressor.compress(image: myImage, maxSizeInKB: 300) {
    // Use compressed image
}
```

---

### 🔹 SENetworkMonitor

```swift
import SwiftEssentials

SENetworkMonitor.shared.startMonitoring()
print(SENetworkMonitor.shared.isConnected)
```

---

### 🔹 EmptyTableRenderer

```swift
import SwiftEssentials

tableView.backgroundView = EmptyTableRenderer.create(message: "No data available")
```

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.
