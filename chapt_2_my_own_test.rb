require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'pry'

=begin

Spaghetti pattern, an anti-pattern, involves lack of percieved architecture
and design. There are single tests or multiple tests intertwined so tightly
together it becomes difficult to tell one apart from another. Tests depends
on execution order of all tests, tends to over-share internal private
components.

Locating element by link
http://www.software-testing-tutorials-automation.com/2014/01/how-to-locate-element-by-link-text-or.html

Automation book
https://www.packtpub.com/mapt/book/Web+Development/9781783982707/2/ch02lvl1sec17/Testing+the+product+review+functionality

Automation practice sites
http://www.seleniumframework.com/demo-sites/
http://automationpractice.com/index.php

=end

class MyOwnSpaghetti < Test::Unit::TestCase

  def test_customer_service_email
    # open browser
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://automationpractice.com")

    assert_equal("http://automationpractice.com/index.php", fox_driver.current_url)

    fox_driver.find_element(:id, "contact-link").click
    # click on SubjectHeading
    binding.pry
    fox_driver.find_element(:id, "uniform-id_contact").click
    # FInd the id below, and click on the option based on nth-child we want
    fox_driver.find_element(:css, 'select#id_contact option:nth-child(1)').click # find what to click here
    # click on EmailAddress
    fox_driver.find_element(:id, "email").send_keys("f.hernandez173+1234567@gmail.com")
    # click on Order Reference
    fox_driver.find_element(:id, "id_order").send_keys("shirt order")
    # click on Message
    fox_driver.find_element(:id, "message").send_keys("Testing the contacts page with this message #{ENV['USERNAME'] || ENV['USER']}")
    # Press send
    fox_driver.find_element(:id, "submitMessage").click
    # assertion to confirm message went through
    assert_equal("Your message has been successfully sent to our team.", fox_driver.find_element(:class, "alert alert-success".text))

    fox_driver.quit
  end

  # def test_searching_for_item
  #   fox_driver = Selenium::WebDriver.for(:firefox)
  #   fox_driver.get("http://automationpractice.com")
  #
  #   # Find search bar and use .clear
  #   fox_driver.find_element(:id, "search_query_top").clear
  #   # input something to search
  #   fox_driver.find_element(:id, "search_query_top").send_keys("shirts")
  #   fox_driver.find_element(:name, "submit_search").click
  #   # find a certain item, and click on it, confirm I clicked on something
  #   # issue below selecting what I want
  #   fox_driver.find_element(:css, "a.product-name").click
  #   # assertion to confirm I am in the right page
  #   # add to cart
  #   fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
  #
  #   fox_driver.quit
  #
  # end

end
