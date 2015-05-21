require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'

RSpec.configure do |config|
  config.include Capybara::DSL
end

Capybara.register_driver :poltergeist do |app|
  options = {inspector: true,
             debug: false,
             default_wait_time: 30,
             timeout: 90}
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.default_wait_time = 10
Capybara.javascript_driver = :poltergeist
Capybara.reset_sessions!
