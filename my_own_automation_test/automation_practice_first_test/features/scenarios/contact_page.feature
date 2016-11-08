
 # New features for automationpractice website for contacts page
@contact_page # Look this up
 Feature: Testing Contacts Page Functionality
  Takes into account errors/ missing fields...

  Scenario: If all required informarion is filled in and sent
  Given I am at contacts page
  And I fill in all the required fields
  When I click Send
  Then I expect a confirmation message

  Scenario: If missing fields are pressent, it should throw errors
  Given I am in the contacts page
  And I have a required field that ha sno information
  When I click Send
  Then I expect an error message to appear



# _________________________________________________________ #
