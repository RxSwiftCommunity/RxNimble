Pod::Spec.new do |s|
  s.name         = "RxNimble"
  s.version      = "4.0.0"
  s.summary      = "Nimble extensions that making unit testing with RxSwift easier 🎉"
  s.description  = <<-DESC
    This library includes functions that make testing RxSwift projects easier with Nimble.
                   DESC
  s.homepage     = "https://github.com/ashfurrow/RxNimble"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/ashfurrow/RxNimble.git", :tag => s.version }
  s.source_files  = "Source/**/*.swift"
  s.dependency "Nimble", "~> 7.0"
  s.dependency "RxSwift", "~> 4.0"
  s.dependency "RxBlocking", "~> 4.0"
  
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"' }
end
