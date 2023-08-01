Pod::Spec.new do |spec|

  spec.name         = "OmPaySDK"
  spec.version      = "1.0.1"
  spec.summary      = "Om pay sdk is a payment SDK. Use it for payment purposes."

  spec.description  = "Om pay SDK is a payment SDK that enables secure payment checkout."

  spec.homepage     = "https://github.com/mmdHussain/OmPaySDK"
  
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }

  spec.author       = { "Mohammed" => "husainmhd92@gmail.com" }
 
  spec.platform     = :ios, "5.0"
  spec.ios.deployment_target = "14.0"
 spec.swift_versions = '5.0'

  spec.source       = { :git => "https://github.com/mmdHussain/OmPaySDK.git", :tag => "#{spec.version}" }

  spec.source_files  = 'OmPaySDK/**/*.{swift, plist}'
  spec.resources = 'OmPaySDK/**/*.{storyboard,xib,xcassets,json,png}'

  spec.exclude_files = "Classes/Exclude"



end
