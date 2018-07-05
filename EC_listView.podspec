

Pod::Spec.new do |s|


  s.name         = "EC_ListView"
  s.version      = "1.0.0"
  s.summary      = "A short description of EC_ListView."
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/cirelir/EC_ListView"

  s.license      = "MIT (example)"

  s.author       = { "cirelir" => "1193436556@qq.com" }

  s.source       = { :git => "http://github.com/cirelir/EC_ListView.git", :tag => "#{s.version}" }



  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  spec.requires_arc          = true
  spec.ios.deployment_target = '8.0'


end
