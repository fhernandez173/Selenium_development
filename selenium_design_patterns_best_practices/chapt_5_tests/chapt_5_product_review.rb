class ProductReview < Test::Unit::TestCase

   def setup
    @product_permalink = TestData.get_product_fixtures["fixture_4"]["url"]
    @fox_driver = Selenium::WebDriver.for(:firefox)
   end

   def teardown
    @fox_driver.quit
   end

   def test_add_new_review
    review_form_info = TestData.get_comment_form_values({:name => "Dima"})
    review_id = generate_new_product_review(review_form_info) # sporadic error here

    review = @fox_driver.find_element(review_id, :id)
    name = review.find_element(:class, "comment-author-metainfo").find_element(:class, "url").text
    comment = review.find_element(:class, "comment-content").text

    assert_equal("Dima", name)
    assert_equal(review_form_info[:comment], comment)

    parsed_date = DateTime.parse(review.find_element(:class, "comment-author-metainfo").find_element(:class, "commentmetadata").text)
    assert_equal(Date.today.year, parsed_date.year)
    assert_equal(Date.today.month, parsed_date.month)
    assert_equal(Date.today.day, parsed_date.day)
   end

   def test_adding_a_duplicate_review
    review_form_info = TestData.get_comment_form_values
    generate_new_product_review(review_form_info) # sporadic error here
    sleep 10
    generate_new_product_review(review_form_info)

    error = @fox_driver.get_inner_text("error-page", :id)
    assert_equal("Duplicate comment detected; it looks as though you\u2019ve already said that!", error)
   end

   private



   def select_desired_product_on_homepage(permalink)
     @fox_driver.click(".special-item a[href*='#{permalink}'].more-info")
   end

   def generate_new_product_review(review)
    navigate_to_homepage
    select_desired_product_on_homepage(@product_permalink)
    fill_out_comment_form(review)
    get_newly_created_review_id
   end

   def fill_out_comment_form(form_info)
    @fox_driver.type_text(form_info[:name], "author", :id)
    @fox_driver.type_text(form_info[:email], "email", :id)
    @fox_driver.type_text(form_info[:url], "url", :id)
    @fox_driver.click("a[title='5']")
    @fox_driver.find_element("comment", :id).clear
    @fox_driver.type_text(form_info[:comment], "comment", :id)
    @fox_driver.click("submit", :id)
   end

   def navigate_to_homepage
    @fox_driver.get(TestData.get_base_url)
   end

   def generate_unique_comment
    "This is a comment for product and is for #{Time.now.to_i}"
   end

   def get_newly_created_review_id
    @fox_driver.current_url.split("#").last
   end

   def find_element(element, strategy=:css)
     @fox_driver.find_element(strategy, element)
   end

   def type_text(text, element, strategy=:css)
     find_element(element, strategy).send_keys(text)
   end

   def click(element, strategy=:css)
     find_element(element, strategy).click
   end
end
