ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  include Capybara::DSL

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_a_user(password: 'secret!!')
    User.create! email:    "101glover@gmail.com",
                 password: password
  end

  def teardown
    $test_user = nil
    super
  end

  def log_me_in
    user = create_a_user()
    $test_user = user
    user
  end
end
