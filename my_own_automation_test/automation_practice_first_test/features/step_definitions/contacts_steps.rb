Given /^I am at contacts page$/ do
  @fox_driver = SupportMethods.new
  @fox_driver.TestingData.site_url.url_extensions("contact_page")
end

And /^I fill in all the required fields$/ do
  dropdown_list = fox_driver.find_element(:id, "id_contact")
  options = dropdown_list.find_elements(tag_name: 'option')
  options.each do |option|
    option.click if option.text == "Customer service"
  end

  # click on EmailAddress
  @fox_driver.find_element(:id, "email").send_keys("f.hernandez173+1234567@gmail.com")
  # click on Order Reference
  @fox_driver.find_element(:id, "id_order").send_keys("shirt order")
  # click on Message
  @fox_driver.find_element(:id, "message").send_keys("Testing the contacts page with this message #{ENV['USERNAME'] || ENV['USER']}")
end

When /^I click Send$/ do
  # Press send
  @fox_driver.find_element(:id, "submitMessage").click
end

Then /^I expect a confirmation message$/ do
  success_message = fox_driver.find_element(:id, "center_column").find_element(:class, "alert-success").text
  assert_equal("Your message has been successfully sent to our team.", success_message)
end

=begin

Cucumber:
https://robots.thoughtbot.com/five-ridiculously-awesome-cucumber-and-webrat
https://github.com/cucumber/cucumber/wiki/Scenario-Outlines
http://stackoverflow.com/questions/4434360/best-bdd-practices-for-designing-cucumber-scenarios-for-forms

=end
