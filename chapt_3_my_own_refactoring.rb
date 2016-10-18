require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class MyOwnSpaghetti

  def setup
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  def teardown
    @fox_driver.quit
  end

  def test_customer_service_email
    #
  end

  def test_searching_for_item
    #
  end

  private

  def get_url
    @fox_driver.get("http://automationpractice.com")
  end

end
