require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  require 'wirble'
  require 'hirb'
end
Wirble.init
Wirble.colorize
Hirb.enable
