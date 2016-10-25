require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require File.join(File.dirname(__FILE__), 'chapt_5_test_data')
I18n.enforce_available_locales = false

class PurchaseFormTests < Test::Unit::TestCase

  def setup
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  def teardown
    @fox_driver.quit
  end

  def test_fillout_purchase_form
    # @fox_driver.get(TestData.get_base_url + "/purchase-forms/perfect-world")
    @fox_driver.get(TestData.get_base_url + "/purchase-forms/slow-animation") # un-comment with #wait_for_animation

    type_text(TestData.get_full_name, "name", :id)
    type_text(TestData.get_credit_card_number, "cc", :id)
    type_text(TestData.get_credit_card_expiry_date.month, "month", :id)
    type_text(TestData.get_credit_card_expiry_date.year, "year", :id)

    wait_for_animation
    click("go", :id)
    wait_for_ajax # added to wait for AJAX in env=staging
    assert_equal("Purchase complete!", get_inner_text("success", :id))
  end

  private

  # method below allows time for animation to finish.
  def wait_for_animation
    Selenium::WebDriver::Wait.new(:timeout => 60).until do
      sleep 1
      # jQuery(':animated').length is used to knwo how many animations are in the page
      @fox_driver.execute_script("return jQuery(':animated').length") == 0
    end
  end

  # method below is used to handle AJAX requests.
  def wait_for_ajax
    # create inatnce of Wait provided by Selenium, time set to 60 secs or until AJAX requests == 0.
    Selenium::WebDriver::Wait.new(:timeout => 60).until do
      sleep 1
      @fox_driver.execute_script("return jQuery.active") == 0
    end
  end

  def select_desired_product_on_homepage(permalink)
    click(".special-item a[href*='#{permalink}'].more-info")
  end

  def generate_new_product_review(review)
    navigate_to_homepage
    select_desired_product_on_homepage(@product_permalink)
    fill_out_comment_form(review)
    get_newly_created_review_id
  end

  def fill_out_comment_form(form_info) # renamed comment to form_info(hash arg)
    # cardcoded data chaned with faker hash data
    type_text(form_info[:name], "author", :id)
    type_text(form_info[:email], "email", :id)
    type_text(form_info[:url], "url", :id)
    click("a[title='5']")
    find_element("comment", :id).clear
    type_text(form_info[:comment], "comment", :id)
    click("submit", :id)
  end

  def navigate_to_homepage
    # This obfuscate the URL of env from test.
    @fox_driver.get(TestData.get_base_url)
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

  def get_inner_text(element, strategy=:css)
    find_element(element, strategy).text
  end

end
