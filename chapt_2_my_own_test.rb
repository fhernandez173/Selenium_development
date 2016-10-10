require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

=begin

Spaghetti pattern, an anti-pattern, involves lack of percieved architecture
and design. There are single tests or multiple tests intertwined so tightly
together it becomes difficult to tell one apart from another. Tests depends
on execution order of all tests, tends to over-share internal private
components.

http://www.seleniumframework.com/demo-sites/
http://automationpractice.com/index.php

=end

class MyOwnSpaghetti < Test::Unit:TestCase

  def test_signing_in
    # open browser
    # 
  end

  def test_searching_through_amazon
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://automationpractice.com")

    # Find search bar and use .clear
    # input something to search
    # find a certain item, and click on it, confirm I clicked on something
    # add to cart
    # Continue process

  end

end
