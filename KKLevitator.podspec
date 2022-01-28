#
# Be sure to run `pod lib lint KKLevitator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KKLevitator'
  s.version          = '1.0.0'
  s.summary          = 'KKLevitator是一个悬浮视图的承载者'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  自定义您的悬浮视图并指定给KKLevitator，KKLevitator作为悬浮视图的承载者会自动并快速帮您实现视图悬浮
                       DESC

  s.homepage         = 'https://github.com/KKWONG1990/KKLevitator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kkwong90' => 'kkwong90@163.com' }
  s.source           = { :git => 'https://github.com/KKWONG1990/KKLevitator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KKLevitator/Classes/**/*'
  
  #是否支持ARC
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'KKLevitator' => ['KKLevitator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
