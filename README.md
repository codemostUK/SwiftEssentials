# SwiftEssentials

![Build Status](https://img.shields.io/github/workflow/status/codemostUK/SwiftEssentials/CI) 
![Swift Version](https://img.shields.io/badge/swift-5.5%2B-orange.svg)
![License](https://img.shields.io/github/license/codemostUK/SwiftEssentials)

## Overview

**SwiftEssentials** is a comprehensive library offering a suite of utilities, components, and extensions to streamline and enhance iOS development. Designed to provide reusable and customizable solutions, SwiftEssentials helps accelerate development and improve code quality with essential tools for various tasks and functionalities.

## Features

### UI Components
- **SEAnimatedImageView**: A `UIImageView` subclass for displaying animated images.
- **SECircularCountDownView**: A `UIView` subclass for displaying a circular countdown timer.
- **SELoadingButton**: A `UIButton` subclass with integrated loading indicator support.
- **SEUILabel**: A `UILabel` subclass with additional customization options.
- **SEUIView**: A `UIView` subclass with utility methods.

### Extensions
- **Foundation Extensions**: Adds methods and properties to `Array`, `Date`, `UIColor`, `UIImage`, and other Foundation types.
- **UIKit Extensions**: Enhances `UIButton`, `UICollectionView`, `UIView`, and other UIKit components with additional functionality.

### Helpers
- **EmptyTableRenderer**: Renders empty states in table views.
- **ExpandableByKeyboardController**: Manages view adjustments when the keyboard is shown.
- **FormValidator**: Validates form input fields.
- **TableData**: Helps manage table view data.

### Protocols
- **Protocols**: Standardized interfaces for various functionalities.

## Installation

### Swift Package Manager (SPM)

To add SwiftEssentials to your project using [Swift Package Manager](https://swift.org/package-manager/), follow these steps:

1. Open your project in Xcode.
2. Go to `File > Swift Packages > Add Package Dependency`.
3. Enter the repository URL: `https://github.com/codemostUK/SwiftEssentials`.
4. Select the version you want to use.

In your `Package.swift` file, add:

```swift
dependencies: [
    .package(url: "https://github.com/codemostUK/SwiftEssentials.git", from: "1.0.0")
]
```

### CocoaPods

To add SwiftEssentials to your project using [CocoaPods](https://cocoapods.org/) , add it to your `Podfile`:

```ruby
# Podfile
target 'YourAppTarget' do
  use_frameworks!
  pod 'SwiftEssentials', '~> 1.0'
end
```


## Usage Examples

### SECircularCountDownView

To use SECircularCountDownView, initialize it and start a countdown:

```swift
import SwiftEssentials

let countDownView = SECircularCountDownView()
countDownView.duration = 60 // Set duration to 60 seconds
countDownView.start()
```

### SEAnimatedImageView

To use SEAnimatedImageView, set up the image view and start animation:

```swift
import SwiftEssentials

let animatedImageView = SEAnimatedImageView()
animatedImageView.imageName = "exampleImage"
animatedImageView.frameCount = 10
animatedImageView.duration = 2.0 // Duration in seconds
animatedImageView.startAnimation()
```

### SELoadingButton

To use SELoadingButton, show and hide the loading indicator:

```swift
import SwiftEssentials

let loadingButton = SELoadingButton()
loadingButton.showLoading()  // Show loading indicator
// ... perform tasks ...
loadingButton.hideLoading()  // Hide loading indicator
```
