#!/usr/bin/env ruby

require 'raptor'

require_relative './lib/tips.rb'

App = Raptor::App.new([Tips])
