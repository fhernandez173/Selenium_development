require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'

class CheeseFinderTests < Test::Unit::TestCase

  # In Test:Unit framework, all test methods must begin with test_ or they will be ignored
  def test_find_some_cheese
    driver = Selenium::WebDriver.for(:firefox)
    driver.get("http://awful-valentine.com/")
    driver.find_element(:id, "searchinput").clear
    driver.find_element(:id, "searchinput").send_keys("cheese")
    driver.find_element(:id, "searchsubmit").click

    driver.quit
  end

end
