require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class ProductReview < Test::Unit::TestCase

  @alter_comment = "teeesstttttt" # Could not use this for interpolation. Some parsing issues.

   def test_add_new_review
     fox_driver = Selenium::WebDriver.for(:firefox)
     fox_driver.get("http://awful-valentine.com/")

     fox_driver.find_element(:css, '.special-item a[href*="our-love-is-special"].more-info').click
     assert_equal("http://awful-valentine.com/our-love-is-special/", fox_driver.current_url)
     assert_equal("Our love is special!!", fox_driver.find_element(:css, ".category-title").text)

     fox_driver.find_element(:id, "author").send_keys("Dima")
     fox_driver.find_element(:id, "email").send_keys("dima@fox_driver.com")
     fox_driver.find_element(:id, "url").send_keys("http://awful-valentine.com")
     fox_driver.find_element(:css, "a[title='5']").click
     fox_driver.find_element(:id, "comment").clear
     fox_driver.find_element(:id, "comment").send_keys("This is a comment for product! #{ENV['USERNAME'] || ENV['USER']} aa")
     fox_driver.find_element(:id, "submit").click

     review_id = fox_driver.current_url.split("#").last
     review = fox_driver.find_element(:id, review_id)

     name = review.find_element(:class, "comment-author-metainfo").find_element(:class, "url").text
     comment = review.find_element(:class, "comment-content").text

     assert_equal("Dima", name)
     assert_equal("This is a comment for product! #{ENV['USERNAME'] || ENV['USER']} aa", comment)

     parsed_date = DateTime.parse(review.find_element(:class, "comment-author-metainfo").find_element(:class, "commentmetadata").text)
     assert_equal(Date.today.year, parsed_date.year)
     assert_equal(Date.today.month, parsed_date.month)
     # assert_equal(Date.today.day, parsed_date.day)

     fox_driver.quit
   end

   def test_adding_a_duplicate_review
     fox_driver = Selenium::WebDriver.for(:firefox)
     fox_driver.get("http://awful-valentine.com/")

     fox_driver.find_element(:css, '.special-item a[href*="our-love-is-special"].more-info').click

     fox_driver.find_element(:id, "author").send_keys("Dima")
     fox_driver.find_element(:id, "email").send_keys("dima@selenium.com")
     fox_driver.find_element(:id, "url").send_keys("http://awful-valentine.com")
     fox_driver.find_element(:css, "a[title='5']").click
     fox_driver.find_element(:id, "comment").clear
     fox_driver.find_element(:id, "comment").send_keys("This is a comment for product! #{ENV['USERNAME'] || ENV['USER']} aa")
     fox_driver.find_element(:id, "submit").click

     error = fox_driver.find_element(:id, "error-page").text
     assert_equal("Duplicate comment detected; it looks as though you\u2019ve already said that!", error)

     selenium.quit
   end
end
