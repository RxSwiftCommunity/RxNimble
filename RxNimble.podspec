Pod::Spec.new do |s|
  s.name         = "RxNimble"
  s.version      = "5.1.1"
  s.summary      = "Nimble extensions that making unit testing with RxSwift easier 🎉"
  s.description  = <<-DESC
    This library includes functions that make testing RxSwift projects easier with Nimble.
                   DESC
  s.homepage     = "https://github.com/RxSwiftCommunity/RxNimble"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "RxSwiftCommunity" => "https://github.com/RxSwiftCommunity" }

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.12"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/RxSwiftCommunity/RxNimble.git", :tag => s.version }
  s.default_subspec = "RxBlocking"
  s.frameworks = "Foundation", "XCTest"
  
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"' }

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/Core/"
    ss.dependency "Nimble", "~> 9.2.0"
    ss.dependency "RxSwift", "~> 6.0"
  end

  s.subspec "RxBlocking" do |ss|
    ss.source_files = "Source/RxBlocking/"
    ss.dependency "RxNimble/Core"
    ss.dependency "RxBlocking"
  end

  s.subspec "RxTest" do |ss|
    ss.source_files = "Source/RxTest/"
    ss.dependency "RxNimble/Core"
    ss.dependency "RxTest"
  end
end
