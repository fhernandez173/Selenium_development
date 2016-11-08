class SearchingTests

  def test_searching_for_item
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

    fox_driver.quit

  end

  def test_no_search_results
    @search_term = "dbhwrthwthn"
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://automationpractice.com")

    fox_driver.find_element(:id, "search_query_top").clear

    fox_driver.find_element(:id, "search_query_top").send_keys(@search_term)
    fox_driver.find_element(:name, "submit_search").click


    fox_driver.find_element(:css, "a.product-name").click

    # add to cart
    # fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
    @no_search_result = fox_driver.find_element(:id, "center_column").find_element(:class, "alert-warning").text
    assert_equal("No results were found for your search #{@search_term}", @no_search_result)

    fox_driver.quit
  end

end
