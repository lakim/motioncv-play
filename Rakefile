# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'MotionCV Play'
  app.deployment_target = "6.0"
  app.device_family = :ipad
  app.interface_orientations = [ :landscape_left, :landscape_right ]
end
