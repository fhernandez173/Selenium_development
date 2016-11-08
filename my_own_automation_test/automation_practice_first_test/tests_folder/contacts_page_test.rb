require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'pry'
require './support_methods'



class TestingContactsPage < Test::Unit::TestCase

  def setup
    @fox_driver_instance = SupportMethods.new
  end

  def teardown
    @fox_driver_instance.quit
  end

  def test_customer_service_email_confirmed_set
    @fox_driver_instance.SupportMethods.get_website_url

    assert_equal("http://automationpractice.com/index.php", fox_driver.current_url)

    fox_driver.find_element(:id, "contact-link").click
    # assert we are in the rigth contacts page
    assert_equal("http://automationpractice.com/index.php?controller=contact", fox_driver.current_url)

    # binding.pry
    # select the top div, and go into the div the select is tigged under
    SupportMethods.filling_out_contacts_form

    fox_driver.quit
  end

  # def test_customer_service_email_missing_field
  #   fox_driver = Selenium::WebDriver.for(:firefox)
  #   fox_driver.get("http://automationpractice.com")
  #
  #   assert_equal("http://automationpractice.com/index.php", fox_driver.current_url)
  #
  #   fox_driver.find_element(:id, "contact-link").click
  #   # assert we are in the rigth contacts page
  #   assert_equal("http://automationpractice.com/index.php?controller=contact", fox_driver.current_url)
  #
  #   SupportMethods.filling_out_contacts_form
  #
  #   fox_driver.quit
  # end

end
