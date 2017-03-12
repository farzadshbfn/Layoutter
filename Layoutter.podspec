Pod::Spec.new do |s|
  s.name             = 'Layoutter'
  s.version          = '1.0.0'
  s.summary          = 'Layoutter lets creating layouts in code (without AutoLayout)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Using Layoutter generating UI's is a lot faster because it does not use AutoLayout. and it's easy to use.
                       DESC

  s.homepage         = 'https://github.com/FarzadShbfn/Layoutter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FarzadShbfn' => 'farzad.shbfn@gmail.com' }
  s.source           = { :git => 'https://github.com/Layoutter', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/*.swift'
  
  # s.resource_bundles = {
  #   'Test' => ['Test/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Alamofire', '~> 4.0'
  # s.dependency 'SwiftyJSON'
  # s.dependency 'CocoaLumberjack/Swift'
  # s.dependency 'Diff'
end