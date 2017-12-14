Pod::Spec.new do |s|

  s.name         = "MMNumberScrollView"
  s.version      = "1.0.2"
  s.summary      = "MMNumberScrollView is used to show number increasing animation with customized number images and scrolling speed. "

  s.description  = <<-DESC
		MMNumberScrollView is used to show number increasing animation with customized number images, dynamic frame size and scrolling speed. 
                   DESC
  s.homepage     = "https://github.com/michaelin1208/MMNumberScrollView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "michaelin1208" => "michaelin1208@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/michaelin1208/MMNumberScrollView.git", :tag => "#{s.version}" }
  s.source_files  = "MMNumberScrollView", "MMNumberScrollView/**/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true
end
