#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mts_analytics_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mts_analytics_plugin'
  s.version          = '2.1.0'
  s.summary          = 'MTSAnalytics plugin for Flutter projects'
  s.homepage         = "https://a.mts.ru/"
  s.license          = { :type => "proprietary" }
  s.author           = 'Mobile TeleSystems Public Joint Stock Company'
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.platform         = :ios, '13.0'
  s.dependency 'Flutter'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.static_framework = true
  s.dependency 'MTAnalytics', '5.1.4'

end
