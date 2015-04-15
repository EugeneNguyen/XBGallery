#
# Be sure to run `pod lib lint XBGallery.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XBGallery"
  s.version          = "0.3"
  s.summary          = "A library allow upload & manage image using plus gallery server"
  s.description      = <<-DESC
                       A library allow upload & manage image using plus gallery server. server side code will be provide in 2 weeks.

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/EugeneNguyen/XBGallery"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "eugenenguyen" => "xuanbinh91@gmail.com" }
  s.source           = { :git => "https://github.com/EugeneNguyen/XBGallery.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/LIBRETeamStudio'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'XBGallery' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'XBCacheRequest'
end
