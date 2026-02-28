#
# Be sure to run `pod lib lint MMTToolForFlareIAP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MMTToolForFlareIAP'
  s.version          = '0.1.2'
  s.summary          = 'A convenient wrapper and packaging tool for Flare IAP'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
MMTToolForFlareIAP is a comprehensive wrapper and packaging tool for the Flare IAP framework.
It provides a simplified and unified API for implementing in-app purchases (IAP) in iOS applications.
This library makes it easy to integrate subscription and transaction management into your projects with minimal boilerplate code.
Built on top of the robust Flare framework, MMTToolForFlareIAP offers an out-of-the-box IAP solution.
                       DESC

  s.homepage         = 'https://github.com/NealWills/MMTToolForFlareIAP.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Neal Wills' => 'aoiiiiyuki@outlook.com' }
  s.source           = { :git => 'https://github.com/NealWills/MMTToolForFlareIAP.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'MMTToolForFlareIAP/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MMTToolForFlareIAP' => ['MMTToolForFlareIAP/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
