require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require_relative '../helpers/support_methods'

class TestingCartAndPayment < Test::Unit::TestCase

  def setup
    @fox_driver_instance = SupportMethods.new
  end

  def teardown
    @fox_driver_instance.quit
  end

  def test_add_items_to_cart
    @fox_driver_instance.get_website_url
    assert_equal("http://automationpractice.com/index.php", @fox_driver_instance.current_url)

    @fox_driver_instance.add_to_cart("shirts")

  end

end
