# This class is a collection of methods commonly used
require 'selenium-webdriver'
require 'rubygems'

class SupportMethods

  def initialize
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  def quit
    @fox_driver.quit
  end

  def self.filling_out_contacts_form
    dropdown_list = @fox_driver.find_element(:id, "id_contact")
    options = dropdown_list.find_elements(tag_name: 'option')
    options.each do |option|
      option.click if option.text == "Customer service"
    end

    # click on EmailAddress
    @fox_driver.find_element(:id, "email").send_keys("f.hernandez173+1234567@gmail.com")
    # click on Order Reference
    @fox_driver.find_element(:id, "id_order").send_keys("shirt order")
    # click on Message
    @fox_driver.find_element(:id, "message").send_keys("Testing the contacts page with this message #{ENV['USERNAME'] || ENV['USER']}")
    # Press send
    @fox_driver.find_element(:id, "submitMessage").click
    # assertion to confirm message went through
    success_message = @fox_driver.find_element(:id, "center_column").find_element(:class, "alert-success").text
    assert_equal("Your message has been successfully sent to our team.", success_message)
  end

  def self.get_website_url
    @fox_driver.get("http://automationpractice.com/")
  end

end
