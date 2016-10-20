require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'

class CheeseFinderTests < Test::Unit::TestCase

  # In Test:Unit framework, all test methods must begin with test_ or they will be ignored
  def test_find_some_cheese
    driver = Selenium::WebDriver.for(:firefox)
    # require 'debug' # can be used step by step to see where error occured
    driver.get("http://awful-valentine.com/")
    driver.find_element(:id, "searchinput").clear
    driver.find_element(:id, "searchinput").send_keys("cheese")
    driver.find_element(:id, "searchsubmit").click

    # Use assert to find out if something is true
    assert(driver.find_element(:class, "entry").text.include?("No Results Found"))
    # following fails
    # assert(driver.find_element(:class, "entry").text.include?("5 Results Found"))

    driver.quit
  end

end
