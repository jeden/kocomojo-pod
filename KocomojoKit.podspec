#
# Be sure to run `pod lib lint KocomojoKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "KocomojoKit"
s.module_name = "Kocomojo"
s.version          = "0.1.0"
s.summary          = "Simple Kocomojo REST client"
s.homepage         = "https://github.com/jeden/kocomojo-pod"
s.license          = 'MIT'
s.author           = { "Antonio Bello" => "jeden@elapsus.com" }
s.source           = { :git => "https://github.com/jeden/kocomojo-pod.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/ant_bello'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*.swift'

end