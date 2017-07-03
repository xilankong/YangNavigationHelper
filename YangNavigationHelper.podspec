Pod::Spec.new do |s|
  s.name             = 'YangNavigationHelper'
  s.version          = '1.0.0'
  s.summary          = 'YangNavigationHelper.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/xilankong/YangNavigationHelper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xilankong' => 'xilankong@126.com' }
  s.source           = { :git => 'https://github.com/xilankong/YangNavigationHelper.git', :tag => s.version.to_s }


  s.ios.deployment_target = '7.0'

  s.source_files = 'YangNavigationHelper/Classes/**/*'
  s.resource = 'YangNavigationHelper/Assets/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
