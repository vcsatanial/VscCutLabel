#
#  Be sure to run `pod spec lint VscCutLabel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "VscCutLabel"
  s.summary      = "将长文进行截取,可以在末位拼接特殊字段,以实现类似展开全文或者提示详情的功能 此方法为类目"
  s.ios.deployment_target = '7.0'
  s.version          = '1.0.0'
  s.homepage         = 'https://github.com/vcsatanial/VscCutLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'VincentSatanial' => '116359398@qq.com' }
  s.source           = { :git => 'https://github.com/vcsatanial/VscCutLabel.git', :tag => s.version }
  
  s.source_files = 'VscCutLabel/*.{h,m}'
  s.requires_arc = true
end
