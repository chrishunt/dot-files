require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  require 'wirble'
  require 'hirb'
  require 'interactive_editor'
end
Wirble.init
Wirble.colorize
Hirb.enable
