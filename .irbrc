require 'rubygems' unless defined? Gem
require 'hirb'
require 'interactive_editor'
require 'fancy_irb'
require "awesome_print"

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

Hirb.enable
AwesomePrint.irb!
