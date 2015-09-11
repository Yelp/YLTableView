Pod::Spec.new do |s|
  s.name         = 'YLTableView'
  s.version      = '1.0.2'
  s.license      = 'Apache V2'
  s.summary      = 'Yelp iOS table view framework'
  s.homepage     = 'https://github.com/Yelp/YLTableView'
  s.authors      = { 'Yelp iOS Team' => 'iphone@yelp.com' }
  s.source       = { :git => 'https://git@github.com/Yelp/YLTableView.git', :tag => 'v' + s.version.to_s }
  s.requires_arc = true

  s.platform     = :ios
  s.ios.deployment_target = '7.0'

  s.public_header_files = 'Classes/**/*.h'
  s.source_files = 'Classes/**/*.{h,m}'
end
