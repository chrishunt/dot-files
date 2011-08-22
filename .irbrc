require 'rubygems' unless defined? Gem
require 'hirb'
require 'wirb'
require 'interactive_editor'
require 'fancy_irb'

Wirb.start
Hirb.enable

FancyIrb.start :colorize => {
  :rocket_prompt => [:blue],
  :result_prompt => [:blue],
  :input_prompt  => nil,
  :irb_errors    => [:red],
  :stderr        => [:red, :bright],
  :stdout        => [:white],
  :input         => nil,
  :output        => true,
}
