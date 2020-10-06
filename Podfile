load 'remove_ios_only_frameworks.rb'

platform :ios, '12.0'
target 'TestProjectApp' do
  pod 'SwiftLint'
  pod 'Reveal-24', :configurations => ['Debug']

  target 'TestProjectApp Tests' do
    use_frameworks!
    inherit! :search_paths
  end
end

def catalyst_unsupported_pods
  [ "Reveal-24" ]
end

post_install do |installer|

  puts 'Determining pod project minimal deployment target'
  
  pods_project = installer.pods_project
  deployment_target_key = 'IPHONEOS_DEPLOYMENT_TARGET'
  deployment_targets = pods_project.build_configurations.map{ |config| config.build_settings[deployment_target_key] }
  minimal_deployment_target = deployment_targets.min_by{ |version| Gem::Version.new(version) }

  puts 'Minimal deployment target is ' + minimal_deployment_target
  puts 'Setting each pod deployment target to ' + minimal_deployment_target

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings[deployment_target_key] = minimal_deployment_target
    end
  end

  installer.configure_support_catalyst
end
