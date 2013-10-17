Pod::Spec.new do |s|
  s.name         = "LittleGhost"
  s.version      = "0.0.1"
  s.summary      = "The synchronous Twitter engine that doesn’t suck!! USE THE MASTER BRANCH"
  s.homepage     = "https://github.com/winterSleep/LittleGhost"
  s.license      = {
    :type => 'New BSD',
    :text => <<-LICENSE
    Copyright (c) 2012-2013 Nicolas Seriot. All rights reserved.
    LICENSE
  }

  s.authors      = { "Nathaniel Symer" => "nate@natesymer.com" }

  s.ios.deployment_target = '5.0'

  s.source       = { :git => "https://github.com/winterSleep/LittleGhost.git"}

  s.source_files  = 'LittleGhostCore/*.{h,m,c}', 'LittleGhostCore/**/*.{h,m,c}'
  s.requires_arc = false

end
