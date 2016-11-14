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

  def add_to_cart(searched_item)
    @fox_driver.find_element(:id, "search_query_top").clear
    # input something to search
    @fox_driver.find_element(:id, "search_query_top").send_keys(searched_item)
    @fox_driver.find_element(:name, "submit_search").click
    # find a certain item, and click on it, confirm I clicked on something
    # issue below selecting what I want
    @fox_driver.find_element(:css, "a.product-name").click
    # assertion to confirm I am in the right page
    # add to cart
    @fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
  end

  def self.searching
    # Find search bar and use .clear
    @fox_driver.find_element(:id, "search_query_top").clear
    # input something to search
    @fox_driver.find_element(:id, "search_query_top").send_keys("shirts")
    @fox_driver.find_element(:name, "submit_search").click
    # find a certain item, and click on it, confirm I clicked on something
    # issue below selecting what I want

    # Below create condition based if TestingData.search_term if false or true
    @fox_driver.find_element(:css, "a.product-name").click
  end

  # _______________________ General Methods _____________________ #

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

  def clear_search_box
    @fox_driver.clear
  end

end
