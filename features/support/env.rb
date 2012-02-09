require 'capybara'
require 'capybara/dsl'
require 'cucumber/websteps'

require_relative '../../app'

Capybara.default_selector = :css
Capybara.app = App

World(Capybara::DSL)
