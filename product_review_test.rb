require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class ProductReview < Test::Unit::TestCase

  @alter_comment = "Testing testing!!"

  def test_add_new_review
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://awful-valentine.com/")

    # Steps for test:
    # below uses CSS to find what we need:
    # <a href="http://awful-valentine.com/our-love-is-special/" class="more-info">More Info</a>

    fox_driver.find_element(:css, '.special-item a[href*="our-love-is-special"].more-info').click
    # Check with assert whether correct product was clicked
    assert_equal("http://awful-valentine.com/our-love-is-special/", fox_driver.current_url)
    assert_equal("Our love is special!!", fox_driver.find_element(:css, ".category-title").text)

    # Fill in fields UserInfo
    fox_driver.find_element(:id, "author").send_keys("Dima")
    fox_driver.find_element(:id, "email").send_keys("dima@selenium.com")
    fox_driver.find_element(:id, "url").send_keys("http://awful-valentine.com")
    # Fill in UserRating
    fox_driver.find_element(:css, "a[title='5']").click
    # Fill in UserComment
    fox_driver.find_element(:id, "comment").clear
    fox_driver.find_element(:id, "comment").send_keys("#{@alter_comment} #{ENV['USERNAME'] || ENV['USER']}")
    fox_driver.find_element(:id, "submit").click

    # Check if product review is properly saved
    review_id = fox_driverdriver.current_url.split('#').last
    review = fox_driver.find_element(:id, review_id)

    # Finds the name
    name = review.find_element(:class, "comment-author-metainfo").find_element(:class, "url").text
    # Finds the comment submitted
    comment = review.find_element(:class, "comment-content").text

    assert_equal("Dima", name)
    assert_equal("#{@alter_comment} #{ENV['USERNAME'] || ENV['USER']}", comment)

    # Finds date
    parsed_date = DateTime.parse(review.find_element(:class, "comment-author-metainfo").find_element(:class, "commentmetadata").text)
    assert_equal(Date.today.year, parsed_date.year)
    assert_equal(Date.today.month, parsed_date.month)
    assert_equal(Date.today.day, parsed_date.day)

    fox_driver.quit
    # create statement where if an error occurs, quit the browser

  end

  def test_adding_a_dup_review
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://awful-valentine.com/")

    fox_driver.find_element(:css, '.special-item a[href*="our-love-is-special"].more-info').click
    # Check with assert whether correct product was clicked
    assert_equal("http://awful-valentine.com/our-love-is-special/", fox_driver.current_url)
    assert_equal("Our love is special!!", fox_driver.find_element(:css, ".category-title").text)

    fox_driver.find_elements(:css, '.special_item a[href*="our-love-is-special"].more-info').click

    fox_driver.find_element(:id, "author").send_keys("Dima")
    fox_driver.find_element(:id, "email").send_keys("dima@selenium.com")
    fox_driver.find_element(:id, "url").send_keys("http://awful-valentine.com")
    # Fill in UserRating
    fox_driver.find_element(:css, "a[title='5']").click
    # Fill in UserComment
    fox_driver.find_element(:id, :comment).clear
    fox_driver.find_element(:id, "comment").send_keys("#{@alter_comment} #{ENV['USERNAME'] || ENV['USER']}")
    fox_driver.find_element(:id, "submit").click

    error = fox_driver.find_element(:id, "error-page").text
    assert_equal("Duplicate comment detected; it loooks as though you\u2019ve already said that!", error)

    fox_driver.quit
  end

end


################## OTHER METHODS TO PLAY WITH ####################

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

=begin
    Using Xpath. the // denotes a relative position of elements compared to each other *did not work for me*
    fox_driver.find_element(:xpath, "//div[@class='special_item']//a[contains(@href,'our_love_is_special') and @class='more-info']")
=end

=begin
Below uses an absolute path. Shoudl avoid hard coding these
/HTML/body?div[4]/div[1]/div[4]/div[1]/a[2]
=end
