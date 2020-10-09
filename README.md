# GMTextField

If you like this pod, please give me a ★ at the top right of the page!

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

GMTextField are customizable TextFields based on material design.  This pod can be helpful if you want to use a simple and easy to use TextFields with cool animations. It also have a multiline textfield.

- They have few different animations
- They support different sizes
- They also support side buttons, place holders and error messages 
- You can define custom verifications using completions

Check out the example if you whant to see it in action!

### Preview Samples

- One line 

| Scale minimize | yShake | Rotation shake | xShake |
| --- | --- | --- | --- |
| ![](https://media.giphy.com/media/L4UUFi18qk8KXetfzL/giphy.gif) | ![](https://media.giphy.com/media/hVO9kzKLcW46v9I4uu/giphy.gif) | ![](https://media.giphy.com/media/IfrF47CD73UH0vY9aA/giphy.gif) | ![](https://media.giphy.com/media/Stim86twa6q3xsYpvx/giphy.gif) |

- Multiline 

| Animation | Scroll |
| --- | --- |
| ![](https://media.giphy.com/media/hrG2uw6Dn5FJIcRW7h/giphy.gif) | ![](https://media.giphy.com/media/Lq6KyxQBv0nI7Gtl57/giphy.gif) | 



Please, Let me know if you find any problem with it.


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.
- iOS 13 or higher.

## Installation

### Cocoapods
To integrate GMCalendar into your Xcode project using CocoaPods, you have to specify it in your  `Podfile` :

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
use_frameworks!

pod 'GMTextField', '~> 0.8'
```

Then, run the following command: 

```bash
$ pod install
```
## Usage and Implementation

1. Create a View in the View Controller you want the TextFiels, and then change the class to GMTextFieldSingularLine or GMTextFieldMultipleLines.

2. import GMTextField

```swift
import GMTextField
```

3. Create view reference in the ViewController

![](https://i.imgur.com/vpjFrN3.png)

![](https://i.imgur.com/yxP0Cu9.png)

4. Modify the customization you want

![](https://i.imgur.com/sMCWPU8.png)

![](https://i.imgur.com/1CuKwN2.png)

5. Implement the delegate methods

![](https://i.imgur.com/qDv2xDw.png)

![](https://i.imgur.com/do69qor.png)

6. Run the app

*NOTE: This is the first version of this pod (0.2)*

## Customization

```swift

protocol GMCustomization {
    var leftImage: UIImage? { get set }
    var rightImage: UIImage? { get set }
    var placeHolder: String! { get set }
    var color: UIColor! { get set }
    var textColor: UIColor? { get set }
    var textFont: UIFont? { get set }
    var errorTextFont: UIFont? { get set }
    var placeHolderTextFont: UIFont? { get set }
    var errorColor: UIColor? { get set }
    var verificationOnlyAtEnd: Bool? { get set }
    var numberOfCharacters: Int? { get set }
    var numberOfLines: Int? { get set }
}

```
You also can moodify few properties on the stpryboard

![](https://i.imgur.com/7d1RSQR.png)


## Author

Gianpiero Mode
Tw: @GianMode
Linkedln: www.linkedin.com/in/gianpiero-mode-a001b6a7

## License

GMCalendar is available under the MIT license. See the LICENSE file for more info.
