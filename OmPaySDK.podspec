
Pod::Spec.new do |spec|

  spec.name         = "OmPaySDK"
  spec.version      = "1.0.1"
  spec.summary      = "Om pay sdk is payment sdk. Use can use this for payment purpose."

  spec.description  = "Om pay sdk is payment sdk. Use can use this for payment purpose and secure payment checkout"

  spec.homepage     = "https://github.com/mmdHussain/OmPaySDK"


  spec.license      = "https://github.com/mmdHussain/OmPaySDK/blob/main/LICENSE.md"

  spec.author             = { "Mohammed" => "husainmhd92@gmail.com" }
 
   spec.platform     = :ios, "5.0"

   spec.ios.deployment_target = "14.0"
 
  spec.source       = { :git => "https://github.com/mmdHussain/OmPaySDK.git", :tag => "#{spec.version}" }


  spec.source_files  = 'OmPaySDK/**/*.swift'
  spec.exclude_files = "Classes/Exclude"

  spec.dependency 'Alamofire'


end
