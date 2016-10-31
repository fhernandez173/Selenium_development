include HttpHelper

Given(/^I am on the purchase page$/) do
  # Do nothing, because we make an HTTP request directly against an endpoint
  # so there is no need for this step at all, but deleting it will
  # make Cucumber think this step is underfined
end

Given(/^I submit valid values on the purchase form$/) do
  url = "http://awful-valentine.com/purchase" # set endpoint URL
  # below we build out the POST data
  @post_data = {
    "name" => TestData.get_full_name,
    "cc" => TestData.get_credit_card_number,
    "month" => TestData.get_credit_card_expiry_date.month,
    "year" => TestData.get_credit_card_expiry_date.year,
    "product_id" => 12345
  }

  # Used the JSON.parse to parse the returned response from server
  @purchase_status = JSON.parse(make_post_request(url, @post_data))
end

Then(/^I should have a successful purchase transaction$/) do
  assert_equal(@post_data["name"], @purchase_status["name"])
  assert_equal(@post_data["product_id"], @purchase_status["product"].to_i)
  assert_equal("purchased", @purchase_status["status"])
end
