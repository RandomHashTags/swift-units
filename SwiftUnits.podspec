Pod::Spec.new do |s|
  s.name = 'SwiftUnits'
  s.version = '1.0.1'
  s.summary = 'Unit conversion Swift library, with other relevant information.'
  s.homepage = 'https://github.com/RandomHashTags/swift-units'
  s.license = { :type => 'CC0 1.0 Universal', :file => 'LICENSE.txt' }
  s.authors = { 'Evan Anderson' => 'imrandomhashtags@gmail.com' }
  s.osx.deployment_target = '10.15'
  s.ios.deployment_target = '13.0'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.source = { :git => 'https://github.com/RandomHashTags/swift-units.git', :tag => s.version.to_s }
  s.swift_versions = ['5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8']
  s.cocoapods_version = '>= 1.5.0'
  s.source_files = 'Sources/**/*'
  s.dependency 'HugeNumbers', '~> 1.0.15'
end
