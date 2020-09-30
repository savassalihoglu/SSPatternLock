#
# Be sure to run `pod lib lint SSPatternLock.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.platform         = :ios
  s.name             = 'SSPatternLock'
  s.version          = '0.1.2'
  s.summary          = 'Easy to use and configurable patternlock view for ios'



  s.homepage         = 'https://github.com/savassalihoglu/SSPatternLock.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Savaş Salihoğlu' => 'mustafasavassalihoglu@gmail.com' }
  s.source           = { :git => 'https://github.com/savassalihoglu/SSPatternLock.git',  :tag => "#{s.version}" }


  s.ios.deployment_target = "12.0"
  s.source_files = 'Source/**/*.swift'
  
  s.swift_version = "5.3"
  # s.resource_bundles = {
  #   'SSPatternLock' => ['SSPatternLock/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
