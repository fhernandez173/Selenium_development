require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require_relative '../helpers/support_methods'
require 'pry'

class SearchingTests < Test::Unit::TestCase

  def setup
    @fox_driver_instance = SupportMethods.new
  end

  def teardown
    @fox_driver_instance.quit
  end

  def test_searching_for_item
    @fox_driver_instance.get_website_url

    @fox_driver_instance.searching(true) # this works
    binding.pry

    # confirm that the page we have has results
    product_list = @fox_driver_instance.find_element(:class, "product_list").find_element(:class, "ajax_block_product")

    # Create assertions to know whether an item showed up here
    product_count = @fox_driver_instance.find_element(:class, "product-count")

    # Find search bar and use .clear
    # @fox_driver_instance.add_to_cart(search_term)

  end

  def test_no_search_results
    @fox_driver_instance.get_website_url

    @fox_driver_instance.searching(false)

    # add to cart
    # @fox_driver_instance.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
    # binding.pry
    no_search_result = @fox_driver_instance.find_element(:id, "center_column").find_element(:class, "alert").text
    assert_equal("No results were found for your search #{search_term}", no_search_result)

  end

end
