

Pod::Spec.new do |s|


  s.name         = "EC_ListView"
  s.version      = "1.0.0"
  s.summary      = "A short description of EC_ListView."
  s.description  = "对弹出选择框的简单封装"

  s.homepage     = "https://github.com/cirelir/EC_ListView"

  s.license      = "MIT"

  s.author       = { "cirelir" => "1193436556@qq.com" }

  s.source       = { :git => "http://github.com/cirelir/EC_ListView.git", :tag => "1.0.0" }
  s.platform     = :ios, '8.0'



  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  spec.requires_arc          = true
  spec.ios.deployment_target = '8.0'


end
