Pod::Spec.new do |s|
  s.name             = 'RxMotionKit'
  s.version          = '0.7.0'
  s.summary          = 'RxMotionKit - reactive motion sensors managing library 🏃'
  s.description      = <<-DESC
                        RxMotionKit is a reactive motion sensors managing library for CoreMotion iOS framework written using RxSwift 🏃
                       DESC

  s.author           = { 'Robert Sobolewski' => 'robert.artur.sobolewski@gmail.com' }
  s.social_media_url = 'https://twitter.com/robsobolewski'
  s.homepage         = 'https://github.com/rsobolewski/RxMotionKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/rsobolewski/RxMotionKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files          = 'Sources/RxMotionKit/*.swift'  
  s.frameworks            = 'Foundation', 'CoreMotion'
  
  s.dependency 'RxSwift', '~> 3.0'
end