#!/usr/bin/env ruby

require 'raptor'
require 'json'

require_relative './lib/tips.rb'

App = Raptor::App.new([Tips])
