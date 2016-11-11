# This class is a collection of methods commonly used
require 'selenium-webdriver'
require 'rubygems'
require_relative '../test_data_file'
require  'pry'

class SupportMethods

  def initialize
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  def quit
    @fox_driver.quit
  end

  def filling_out_contacts_form
    dropdown_list = @fox_driver.find_element(:id, "id_contact")
    options = dropdown_list.find_elements(tag_name: 'option')
    options.each do |option|
      option.click if option.text == "Customer service"
    end

    # click on EmailAddress
    @fox_driver.find_element(:id, "email").send_keys(TestingData.user_email)
    # click on Order Reference
    @fox_driver.find_element(:id, "id_order").send_keys(TestingData.order_reference)
    # click on Message
    @fox_driver.find_element(:id, "message").send_keys(TestingData.message_box_input)
    # Press send
    @fox_driver.find_element(:id, "submitMessage").click
    # assertion to confirm message went through

  end

  def get_website_url
    @fox_driver.get(TestingData.site_url)
  end

  def current_url
    @fox_driver.current_url
  end

  def go_to_contacts_page
    @fox_driver.find_element(:id, "contact-link").click
  end

  def text(text, element, strategy)
    @fox_driver.find_element(strategy, element).send_keys(text)
  end

  def find_element(strategy, element)
    @fox_driver.find_element(strategy, element)
  end

end
