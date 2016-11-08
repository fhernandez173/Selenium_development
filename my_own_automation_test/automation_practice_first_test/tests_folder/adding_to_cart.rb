require 'rubygems'
require 'selenium-webdriver'

class TestingCartAndPayment

  def test_payment_info_into_fields
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://automationpractice.com")

    # Find search bar and use .clear
    fox_driver.find_element(:id, "search_query_top").clear
    # input something to search
    fox_driver.find_element(:id, "search_query_top").send_keys("shirts")
    fox_driver.find_element(:name, "submit_search").click
    # find a certain item, and click on it, confirm I clicked on something
    # issue below selecting what I want
    fox_driver.find_element(:css, "a.product-name").click
    # assertion to confirm I am in the right page
    # add to cart
    fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click

    # ___________________FINISH CART TESTS____________________ #

    
  end

end
