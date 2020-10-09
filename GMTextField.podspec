#
# Be sure to run `pod lib lint GMTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GMTextField'
  s.version          = '0.3.0'
  s.summary          = 'GMTextField are customizable TextFields based on material design.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'GMTextField are customizable TextFields based on material design.  This pod can be helpful if you want to use a simple and easy to use TextFields with cool animations. It also have a multiline textfield.'

  s.homepage         = 'https://github.com/gianmode1803/GMTextField.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gianmode1803@hotmail.com' => 'gianmode1803@hotmail.com' }
  s.source           = { :git => 'https://github.com/gianmode1803/GMTextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gianmode'

  s.ios.deployment_target = '13.0'

  s.source_files = 'GMTextField/Classes/**/*'
  
  s.swift_versions = '5.0'
  
end
