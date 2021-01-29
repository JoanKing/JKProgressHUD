
Pod::Spec.new do |s|
  s.name             = 'JKProgressHUD'
  s.version          = '0.1.2'
  s.summary          = 'JKProgressHUD是对MBProgressHUD的扩展'
  s.description      = 'JKProgressHUD是一个针对扩展MBProgressHUD演示的一个使用用例'

  s.homepage         = 'https://github.com/JoanKing/JKProgressHUD'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JoanKing' => 'jkironman@163.com' }
  s.source           = { :git => 'https://github.com/JoanKing/JKProgressHUD.git', :tag => s.version.to_s }
  s.social_media_url = "https://www.jianshu.com/u/8fed18ed70c9"

  s.ios.deployment_target = '9.0'
    # swift 支持的版本
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source_files = 'JKProgressHUD/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JKProgressHUD' => ['JKProgressHUD/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'MBProgressHUD'
end
