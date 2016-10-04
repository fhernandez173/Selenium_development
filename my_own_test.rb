require 'selenium-webdriver'
require 'rubygems'
require 'test/unit'
require 'pry'
class MyOwnTest < Test::Unit::TestCase

  def test_try_it_out
    @ff_browser = Selenium::WebDriver.for(:firefox)
    @ff_browser.get("https://www.google.com/")
    @ff_browser.find_element(:name, "q").clear
    @ff_browser.find_element(:name, "q").send_keys("BlackBerry")
    @ff_browser.find_element(:class, "sbico").click

    # browser waits 5 seconds
    sleep 5

    @ff_browser.quit

  end



end
