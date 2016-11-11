require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'pry'
# require_relative or join the file
require_relative '../helpers/support_methods'



class TestingContactsPage < Test::Unit::TestCase

  def setup
    @fox_driver_instance = SupportMethods.new
  end

  def teardown
    @fox_driver_instance.quit
  end

  def test_customer_service_email_confirmed_set
    # binding.pry
    @fox_driver_instance.get_website_url
    assert_equal("http://automationpractice.com/index.php", @fox_driver_instance.current_url)

    @fox_driver_instance.go_to_contacts_page
    # assert we are in the rigth contacts page
    assert_equal("http://automationpractice.com/index.php?controller=contact", @fox_driver_instance.current_url)

    # binding.pry
    # select the top div, and go into the div the select is tigged under
    @fox_driver_instance.filling_out_contacts_form

    success_message = @fox_driver_instance.find_element(:id, "center_column").find_element(:class, "alert-success").text
    assert_equal("Your message has been successfully sent to our team.", success_message)
  end

  # def test_customer_service_email_missing_field
  #   @fox_driver_instance = Selenium::WebDriver.for(:firefox)
  #   @fox_driver_instance.get("http://automationpractice.com")
  #
  #   assert_equal("http://automationpractice.com/index.php", @fox_driver_instance.current_url)
  #
  #   @fox_driver_instance.find_element(:id, "contact-link").click
  #   # assert we are in the rigth contacts page
  #   assert_equal("http://automationpractice.com/index.php?controller=contact", @fox_driver_instance.current_url)
  #
  #   SupportMethods.filling_out_contacts_form
  # end

end
