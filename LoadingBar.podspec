#
# Be sure to run `pod lib lint LoadingBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LoadingBar'
  s.version          = '0.0.1'
  s.summary          = 'A simple animatable loading bar'
  s.description      = <<-DESC
A loading bar can be added to the navigation bar or toolbar, or else where in the app, where impossible to add UIActivityIndicatorView
                       DESC

  s.homepage         = 'https://github.com/iharkatkavets/ios.loading-bar.swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ihar Katkavets' => 'job4ihar@gmail.com' }
  s.source           = { :git => 'https://github.com/Ihar Katkavets/LoadingBar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.7'

  s.source_files = 'LoadingBar/Classes/**/*'
  
end
