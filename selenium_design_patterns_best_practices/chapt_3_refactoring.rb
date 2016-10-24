=begin
Here we create a setup and teardown method, similar to cucumber's
`Background` and Rspec has `before`.

Assertions are removed for later use in Data Driven Testing.
=end

require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'

class ProductReview < Test::Unit::TestCase

  # Used to get environment ready in a test-ready state.
  def setup
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  # Used to clean up after tests
  def teardown
    @fox_driver.quit
  end

  def test_add_new_review
    unique_comment = generate_unique_comment
    review_id = generate_new_product_review(unique_comment)

    review = find_element(:id, review_id)

    name = review.type_text(:class, "comment-author-metainfo").find_element(:class, "url")
    comment = review.type_text(:class, "comment-content")

    assert_equal("Dima", name)
    assert_equal(unique_comment, comment)

    parsed_date = DateTime.parse(review.find_element(:class, "comment-author-metainfo").text(:class, "commentmetadata"))
    assert_equal(Date.today.year, parsed_date.year)
    assert_equal(Date.today.month, parsed_date.month)
    assert_equal(Date.today.day, parsed_date.day)
  end

  def test_adding_a_duplicate_review
    unique_comment = generate_unique_comment
    generate_new_product_review(unique_comment)
    sleep 10 # elapse time to avoid rapid product review fraud detection mechanism
    generate_new_product_review(unique_comment)

    error = type_text(:id, "error-page")
    assert_equal("Duplicate comment detected; it looks as though you\u2019ve already said that!", error)
  end

  # http://rubylearning.com/satishtalim/ruby_access_control.html
  # Used to call only by context of current object. Cannot invoke another objects private methods
  private

  def select_desired_product_on_homepage
    click(:css, '.special-item a[href*="our-love-is-special"].more-info')
  end

  def generate_new_product_review(review)
    navigate_to_homepage
    select_desired_product_on_homepage
    fill_out_comment_form(review)
    get_newly_created_review_id
  end

  # The following code appears twice, so it becomes one method
  def fill_out_comment_form(comment)
    type_text(:id, "author").send_keys("Dima")
    type_text(:id, "email").send_keys("dima@fox_driver.com")
    type_text(:id, "url").send_keys("http://awful-valentine.com")
    click(:css, "a[title='5']").click
    find_element(:id, "comment").clear
    type_text(:id, "comment").send_keys(comment)
    click(:id, "submit").click
  end

  def navigate_to_homepage
    @fox_driver.get("http://awful-valentine.com/")
  end

  # Following to guarantee unique data when writing tests
  def generate_unique_comment
    "This is a comment for product and is for #{Time.now.to_i}"
  end

  def get_newly_created_review_id
    @fox_driver.current_url.split("#").last
  end

  #  method below created due to the constant usage of find_element
  # Defaults to :css if no strategy is specified
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

=begin
__________________NOTES_________________
Hermetic test pattern
All dependecy on other tests/ third-party services that cannot be controlled
should be avoided at all costs. Tests should be independet and self-sufficient.

Advantages:
* Modular: each test is standalone
* Cleant start: each test runs in its own env
* Resilience: each test responcible for its own env.
* Can be executed in any order

Disavantages:
* Each test needs to be designed to be self-sufficient
* Run time increases
* Resource needs increase

=end
