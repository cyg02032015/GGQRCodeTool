Pod::Spec.new do |s|
  s.name         = "GGQRCodeTool"
  s.version      = "1.0.1"
  s.summary      = "GGQRCodeTool can scan、recognition、generate qrcode"
  s.homepage     = "https://github.com/cyg02032015/GGQRCodeTool"
  s.license      = "MIT"
  s.author             = { "youngKook" => "youngkook1992@163.com" }
  s.social_media_url   = "http://youngkook.cn/"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/cyg02032015/GGQRCodeTool.git", :tag => s.version }
  s.source_files  = "GGQRCodeTool"
  s.requires_arc = true
end