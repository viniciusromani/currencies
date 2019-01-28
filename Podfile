# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Currencies' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Currencies
  pod 'Alamofire'
  pod 'Swinject'
  pod 'SnapKit'
  pod 'R.swift', '~> 5.0.2'

  target 'CurrenciesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if ['SnapKit'].include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '4.0'
              end
          end
      end
  end
end
