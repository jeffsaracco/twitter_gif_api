require File.expand_path '../../api.rb', __FILE__
require 'rspec'
require "rack/test"
require 'pry'

ENV['RACK_ENV'] = 'test'

module RackSpecHelpers
  include Rack::Test::Methods
  attr_accessor :app
end

RSpec.configure do |config|
  config.include RackSpecHelpers, feature: true
  config.before feature: true do
    self.app = Sinatra::Application
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
