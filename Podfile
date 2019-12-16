# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOSCcodeGeneral' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSCcodeGeneral
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireImage', '~> 3.1'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
            config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = ['$(FRAMEWORK_SEARCH_PATHS)']
        end
    end

end
