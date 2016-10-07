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
    # debug

    # browser waits 5 seconds
    sleep 5
    # assert to confirm result include BlackBerry Wiki info
    assert(@ff_browser.find_element(:id, "rhs_block").text.include?("BlackBerry Limited, formerly known as Research In Motion Limited, is a Canadian multinational telecommunication and wireless equipment company best known to the general public as the developer of the ..."))

    @ff_browser.quit
  end

end
