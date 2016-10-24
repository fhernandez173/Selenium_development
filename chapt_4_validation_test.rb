require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require File.join(File.dirname(__FILE__), 'chapt_4_test_data')

class ProductValidationsTests < Test::Unit::TestCase

  def setup
    @fox_driver = Selenium::WebDriver.for(:firefox)
  end

  def teardown
    @fox_driver.quit
  end

  def test_all_products_with_fixtures
    TestData.get_product_fixtures.each do |product_info|
      # combine product_info with TestData to navigate to product's page
      @fox_driver.get(TestData.get_base_url + product_info["url"])
      verify_product_info(product_info)
    end
  end

  def test_all_products_with_api_response
    TestData.get_product_from_api.each do |product_info|
      # combine product_info with TestData to navigate to product's page
      @fox_driver.get(TestData.get_base_url + product_info["url"])
      verify_product_inf0(product_info)
    end
  end

 # _________REFACTORING CODE__________ #
 private

 def verify_product_info(product_info)
   failure_info = "Product Name: #{product_info['name']} \nPermalink #{product_info['url']}\n"
   #compares product's name from fixtures to div with category-title
   assert_equal(product_info['name'], get_product_title, failure_info)
   # compares current url from the fixture url
   assert_equal('#{TestData.get_base_url + product_info["url"].gsub(/^\//, "")}/', get_current_url, failure_info)
   # Following two assertions used to verify description and price on page
   assert_equal(product_info['description'], get_product_description, failure_info)
   assert_equal(product_info['price'], get_product_price, failure_info)
 end

 def get_product_title
  @fox_driver.find_element(:class, "category-title").text
 end

 def get_product_description
  @fox_driver.find_element(:id, "main-products").find_element(:class, "content").text
 end

 def get_product_price
  @fox_driver.find_element(:class, "price-tag").text.gsub(/[\n\$]/, "")
 end

 def get_current_url
  @fox_driver.current_url
 end

end
