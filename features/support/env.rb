require 'capybara'
require 'capybara/dsl'
require 'cucumber/websteps'
require 'capybara/webkit'

require_relative '../../app'

Capybara.default_selector = :css

Capybara.app = App

Around "@javascript" do |example, block|
  Capybara.current_driver = Capybara.javascript_driver
  block.call
  Capybara.current_driver = Capybara.default_driver
end

Capybara.javascript_driver = :webkit

World(Capybara::DSL)
