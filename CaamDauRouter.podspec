
Pod::Spec.new do |s|
  s.name             = 'CaamDauRouter'
  s.version          = '1.1.0'
  s.summary          = 'A iOS development toolbox (iOS 开发工具箱(模块组件) Swift 版).'
  s.description      = <<-DESC
  TODO: iOS 开发组件 Swift 版：iOS项目开发通用&非通用型模块代码，多功能组件，可快速集成使用以大幅减少基础工作量；便利性扩展&链式扩展、UI排班组件Form、正则表达式扩展RegEx、计时器管理Timer、简易提示窗HUD、AppDelegate解耦方案、分页控制Page、自定义导航栏TopBar、阿里矢量图标管理IconFonts、MJRefresh扩展、Alamofire扩展......
  附.各种类库使用示例demo.
                       DESC

  s.homepage         = 'https://github.com/CaamDau/Router'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => 'https://github.com/CaamDau/Router.git', :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.source_files = 'Router/**/*'
  s.frameworks = 'Foundation'
end
