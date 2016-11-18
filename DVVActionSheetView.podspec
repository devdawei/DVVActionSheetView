

Pod::Spec.new do |s|

s.name         = 'DVVActionSheetView'
s.summary      = '自定义的ActionSheetView，解决了UIAlertController在iPad和iPhone上使用方式不一致的问题。'
s.version      = '1.0.0'
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.authors      = { 'devdawei' => '2549129899@qq.com' }
s.homepage     = 'https://github.com/devdawei'

s.platform     = :ios
s.ios.deployment_target = '7.0'
s.requires_arc = true

s.source       = { :git => 'https://github.com/devdawei/DVVActionSheetView.git', :tag => s.version.to_s }

s.source_files = 'DVVActionSheetView/DVVActionSheetView/*.{h,m}'

s.frameworks = 'Foundation', 'UIKit'

end
