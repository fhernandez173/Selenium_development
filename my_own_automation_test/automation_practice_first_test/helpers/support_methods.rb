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

  def add_to_cart(arg)
    @fox_driver.searching(arg)
    # find a certain item, and click on it, confirm I clicked on something
    # issue below selecting what I want
    @fox_driver.find_element(:css, "a.product-name").click
    # assertion to confirm I am in the right page
    # add to cart
    @fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
  end

  def searching(arg)
    # Find search bar and use .clear
    @fox_driver.find_element(:id, "search_query_top").clear
    # input something to search
    @fox_driver.find_element(:id, "search_query_top").send_keys(TestingData.search_term(arg))
    @fox_driver.find_element(:name, "submit_search").click
  end

  def logIntoAccount
    #
  end

  def createAccount
    # add email
    users_email     = TestingData.user_email
    users_firstname = TestingData.user_first_name
    users_lastname  = TestingData.user_first_name
    users_password  = TestingData.user_password
    @fox_driver.find_element(:class, "form-group").find_element(:id, "email_create").send_keys(users_email)
    @fox_driver.find_elements(:class, "submit")[0].find_element(:id, "SubmitCreate").click
    # @fox_driver.find_elements(:class, "submit").each do |div|
    #   if div.include?(@fox_driver.find_element(:id, "SubmitCreate"))
    #     div.find_element(:id, "SubmitCreate").click
    #   end
    # end
    # add add details in fields
    # binding.pry
    sleep 5 # need better alt to wait for Ajax request
    @fox_driver.find_element(:id, "customer_firstname").send_keys(users_firstname)
    @fox_driver.find_element(:id, "customer_lastname").send_keys(users_lastname)
    #  confirm with assertion email is present
    # assert_equal(@fox_driver.find_element(:id, "email").text, users_email)

    @fox_driver.find_element(:id, "passwd").send_keys(users_password)

    # Date of birth ropdown menus
    binding.pry
    date_of_birth = @fox_driver.find_element(:class, "form-group")
    day_dropdown = @fox_driver.find_element(:class, "col-xs-4").find_element(:id, "uniform-days")
    day_options = day_dropdown.find_elements(tag_name: 'option')
    day_options.each do |option|
      option.click if option.text == 2
    end

    @fox_driver.find_element(:class, "col-xs-4").find_element(:id, "uniform-days").find_element(tag_name: 'option'.text)

    month_dropdown = @fox_driver.find_element(:class, "col-xs-4")[1].find_element(:id, "uniform-months")
    year_dropdown = @fox_driver.find_element()

  end

  # _______________________ General Methods _____________________ #

  def get_website_url
    @fox_driver.get(TestingData.site_url)
  end

  def current_url
    @fox_driver.current_url
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

  def go_to_contacts_page
    @fox_driver.find_element(:id, "contact-link").click
  end

  def go_to_accounts_page
    @fox_driver.find_element(:class, "login").click
  end

  def assert_equal(arg1, arg2)
    @fox_driver.assert_equal(arg1, arg2)
  end

end
