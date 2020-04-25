

Pod::Spec.new do |s|
  s.name             = 'Sign'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Find.'



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/CaamDau'
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Classes/**/*'
  s.resource_bundles = {
    'Sign' => ['Nib/*.{storyboard,xib}']
  }
  s.dependency 'CaamDauExtension'
  s.dependency 'CaamDauRouter'
  s.dependency 'Router'
end
