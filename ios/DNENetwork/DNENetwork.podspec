#
# Be sure to run `pod lib lint DNENetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DNENetwork'
  s.version          = '1.0.5'
  s.summary          = '网络库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
zaky所使用的网络库
                       DESC

  s.homepage         = 'http://gitlab-ce.gzshujiu.com/zaky-iOS/DNENetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DeanDever' => 'deandever' }
  s.source           = { :git => 'http://gitlab-ce.gzshujiu.com/zaky-iOS/DNENetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DNENetwork/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DNENetwork' => ['DNENetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.prefix_header_contents = <<-EOS
  
  #ifdef __OBJC__

  #import "DNENetworkManager.h"
  #import <YYCategories/YYCategories.h>
  #import <YYModel/YYModel.h>

  #endif /* __OBJC__*/

  EOS
  
  s.dependency 'AFNetworking', '~> 4.0'
  s.dependency 'YYModel'
  s.dependency 'YYCategories'
end
