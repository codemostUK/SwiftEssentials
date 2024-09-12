Pod::Spec.new do |s|
  s.name             = 'SwiftEssentials'
  s.module_name      = 'SwiftEssentials'
  s.version          = '1.0.1'
  s.license          = { :type => 'Copyright', :text => <<-LICENSE
									Copyright 2024
									Codemost Limited. 
									LICENSE
								}
  s.homepage         = 'http://www.codemost.co.uk/'
  s.author           = { 'Codemost Limited' => 'tolga@codemost.co.uk' }
  s.summary          = 'A collection of essential Swift utilities and UI components for iOS development.'
  s.description     = <<-DESC
                        SwiftEssentials provides a comprehensive set of utilities and UI components designed to enhance iOS development. 
                        It includes:

                        - **UI Components**: Customizable components like `SEAnimatedImageView`, `SECircularCountDownView`, `SELoadingButton`, `SEUILabel`, and `SEUIView` for efficient UI development.
                        - **Extensions**: A wide range of extensions for Foundation and UIKit, such as `Array`, `Date`, `UIColor`, `UIImage`, `UIView`, and more, to streamline common tasks and improve code readability.
                        - **Helpers**: Useful helper classes including `EmptyTableRenderer`, `ExpandableByKeyboardController`, `FormValidator`, and `TableData` for better handling of common functionalities and UI patterns.
                        - **Protocols**: A set of protocols for defining and implementing standard interfaces.

                        Designed to be easily integrated and utilized in your iOS projects, SwiftEssentials helps in speeding up development and improving code quality.
                       DESC

  s.source           = { :git => 'https://github.com/codemostUK/SwiftEssentials.git',
 								 :tag => s.version.to_s }
  s.source_files     = 'Sources/Classes/**/*.{swift}', 'Sources/Extensions/**/*.{swift}', 'Sources/Helpers/**/*.{swift}', 'Sources/PropertyWrapper/**/*.{swift}', 'Sources/Protocols/**/*.{swift}', 'Sources/Views/**/*.{swift}', 'Sources/SwiftEssentials.swift'
  s.documentation_url = 'https://github.com/codemostUK/SwiftEssentials/blob/main/README.md'
  s.requires_arc    = true
  s.ios.deployment_target = '13.0'
  s.swift_version   = '5.5'
  s.frameworks = 'UIKit', 'Foundation'
end