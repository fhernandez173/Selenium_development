require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class ProductReview < Test::Unit::TestCase

  def test_add_new_review
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://awful-valentine.com/")

    # Steps for test:
    # Locate/ click MORE INFO on SPECIAL OFFERS
    # Below uses an ID to find the element we want
    # fox_driver.find_element(:id, "more-info-product-25-special-offer").click

    # Below uses an absolute path. Shoudl avoid hard coding these
    # /HTML/body?div[4]/div[1]/div[4]/div[1]/a[2]

=begin
    Below uses a relative path to the element we need. Use the target URL.
    using a chained selector strategy works although verbose
    collect all divs that contain special_item
    special_items = fox_driver.find_elements(:class, "special_item")
    # collect the more info buttons
    more_info_buttons = special_items.collect do |special_item|
      special_item.find_elements(:class, "more-info")
    end
    # picking the correct href attribute that matches URL
    button_to_click = more_info_buttons.find do | button|
      button.attribute("href").include?("our_love_is_special")
    end
=end

    # below uses CSS to find what we need:
    fox_driver.find_elements(:css, '.special_item a[href*="our_love_is_special"].more-info')
    #
    # Using Xpath. the // denotes a relative position of elements compared to each other *did not work for me*
    # fox_driver.find_element(:xpath, "//div[@class='special_item']//a[contains(@href,'our_love_is_special') and @class='more-info']")

    # Check with assert whether correct product was clicked
    # Fill in fields UserInfo
    # Fill in UserRating
    # Fill in UserComment
    # Check if product review is properly saved

    # ff_driver.quit
    # create statement where if an error occurs, quit the browser

  end

end
