require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require_relative '../helpers/support_methods'
require 'pry'

class LoginSignupTest < Test::Unit::TestCase

  def setup
    @fox_driver_instance = SupportMethods.new
  end

  def teardown
    @fox_driver_instance.quit
  end

  def test_signup
    # get URL
    @fox_driver_instance.get_website_url
    @fox_driver_instance.go_to_accounts_page
    # confirm I am in the right page with assert_equal
    assert_equal("http://automationpractice.com/index.php?controller=authentication&back=my-account", @fox_driver_instance.current_url)
    # find the signup component
    @fox_driver_instance.createAccount
    # start the flow.
    # use TestingData file to send the email and passowrd info
  end

  def test_login
    # get URL
  end

end
