require 'capybara'
require 'capybara/dsl'
require 'cucumber/websteps'

Capybara.default_selector = :css

World(Capybara::DSL)
