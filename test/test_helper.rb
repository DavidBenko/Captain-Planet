# -*- encoding : utf-8 -*-
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/reporters'
require 'capybara/rails'

Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Capybara::DSL
  include Capybara::Assertions

  def teardown
    Capybara.reset_session!
    Capybara.use_default_driver
  end
end

Minitest::Reporters.use!
