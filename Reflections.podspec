#
#  Be sure to run `pod spec lint Reflections.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "Reflections"
  spec.version      = "0.1.0"
  spec.summary      = "An advanced reflection library for Swift"

  spec.description  = <<-DESC
Reflections is an advanced library for Swift designed to add convenience through reflection. The intention is to leverage the Objective-C Runtime API to provide Swift a large amount of customization during the runtime.
                   DESC

  spec.homepage     = "https://github.com/BSFishy/Reflections/"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Matt Provost" => "mprovost@webcreek.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/BSFishy/Reflections.git", :tag => "#{spec.version}" }
  spec.source_files  = "Reflections/**/*.{swift}"

  spec.swift_version = "5.0"
end
