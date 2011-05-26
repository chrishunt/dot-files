require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  require 'wirb'
  require 'hirb'
  require 'interactive_editor'
  require 'fancy_irb'
end

Hirb.enable
Wirb.start
FancyIrb.start
